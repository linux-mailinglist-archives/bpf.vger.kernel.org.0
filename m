Return-Path: <bpf+bounces-41401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C654996AEA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D303B262EE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC061E1A07;
	Wed,  9 Oct 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OW9UEQkF"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833161E131E;
	Wed,  9 Oct 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478325; cv=fail; b=A6Qgd5tpmXeUVhC1gV8G3vCbnrONblOotLziztdzyPHEXAK7g7weejUE/LiLe01Osh3ro2U0c47fv/VSuYXn22uDQTivdhAAIwr4+CPV1Vk4N5AnhtqRkENHT4KEJHIfDeKROwaFE/XHBHbCQ0GEyysaKaTGvn8X3KTe1xWpNIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478325; c=relaxed/simple;
	bh=EpJDvNUb/T0+lcEnCoAZ2j/TzkbxOswf1NE7xNbqTp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQnMqIh4/w6dJ8Cs67nllu3cRiAhxqtvaaqKcmJODHD5RNB4ZsUoV/Lahev+LnofHUxJ7u4l7gJ5OHWorx+o6mY3XOwBzbAQ+gnCJ8SA/p785OoBKY9QfAZVjrJRqkwNrNFjXdiDgFtg6YZ8q4MEWlM/FmUxvPTb0EQCWBMhw9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OW9UEQkF; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDlFD3JxHrLHJihgkxYBnXiBMv7IOrubwtdzCcxA8LWynd0uk2feMIYpXnMm25Wq6B6jVnvwqugm8LmI/YHTM2vPRmDn8X/2b/qEL+NNCzkajzAASCr5krW4PH2Q5W/2onXcEN64NxQxUKj1gKSs9GePygCeWrE6j/5vroGdCoDDPew/nffQvqDse/NTKkPLo8v8NVQptTauSCunJpQP/JBK+b/dsO/IL9vroRNZLb8IsaEcC6wpKjYS50JiRwJmGmZ1mkeyXrynSVOTQd2hN1li9kdBESz4I+NyyPnX19kMPePqzpciXJXPXMKkiXnoPXlAUdaFX8XtYZEjgDdidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpJDvNUb/T0+lcEnCoAZ2j/TzkbxOswf1NE7xNbqTp8=;
 b=sIVbZzlZUX0Xy7CdpB4uqOAPTSk6ObzuXjnKKeAMHv397sAmNKIzrvM4DwXjThX2BYp6YiE83hLS92Fs9SLSUwpEIiJY+3OO0EKs9DguAta2HaSEhUm1GYGJe0AXvjUcJQ2qtf/RYS04DiH58K60BGXP5jHuKmsCTWdBVQRQPRLnORgxAeDwxr0gRMq6eyQ8TaUYFAKZ8mChqG9b6EnrFn6AEUTacFeqk6NldV1jQgjuAj1WOTyJdOJE8gzeBxYZ+uz/eCo7ud7enoNDOfRbR7vRybwYN7aHmcCmsGRapd5DZXORaEiMuMX9quYY+tOlaibhdnTCTE6A2X10oCXU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpJDvNUb/T0+lcEnCoAZ2j/TzkbxOswf1NE7xNbqTp8=;
 b=OW9UEQkFpLGlrD7WPQPVyxnme/AJaDsb1JGsTKN1vOKUqQMEW+lLqEu3YAQgdetXRgl26Hmq77uTlRn+d91SaRFlcastHtC2/BPaWfTOI5Bs8SQDWFFoxgRvsEk672QG+2MrSAGIg5BdMpBSyn6WconCi8514y5vuOb21aiDYaransOLaOoHfhERGbXdfa9WQ6nl6iu077IgJiLsl0iRay4Z3JMy8lRrJWSrrnVX3KifnAr2gyLDkSRqjuGuOs4+xD8stSPcAKpaMYMo+tAeu3MXE2gYvMvplZ39YPF3nltdPZQCUUgAxIonmWBhFtLRF2ECYyyVfdEaDMlju6NRuw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7840.eurprd04.prod.outlook.com (2603:10a6:102:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:52:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 12:52:00 +0000
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
Subject: RE: [PATCH v3 net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Thread-Topic: [PATCH v3 net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Thread-Index: AQHbGiwxJigxuijjIEqtCQOrK8aL/LJ+SjMAgAAT76A=
Date: Wed, 9 Oct 2024 12:52:00 +0000
Message-ID:
 <PAXPR04MB85103ACE868025F45EC172AC887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-3-wei.fang@nxp.com>
 <20241009113500.kgd75g72wlknb46n@skbuf>
In-Reply-To: <20241009113500.kgd75g72wlknb46n@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7840:EE_
x-ms-office365-filtering-correlation-id: c07a9bae-6d01-4fd5-4909-08dce8612a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZG5UdlAyOC9ONmkrMFdMMWF6eUVWaFUvZUNGT3p3UFdDYWM2QVI5U0w4UlBE?=
 =?gb2312?B?TUtkV21JMkx4SjJHT3ExQUxtRU0vTFc0b3A2V04wZGJCSzA5WFlJb3FCSWd0?=
 =?gb2312?B?d1owVTFkaVdkd3hVbWVkMXdIYlViTUNOYlpqdlFKV0o3c0RkbVMrQlhYR2Ns?=
 =?gb2312?B?VGV4US9KYW1yZXpyRnB6elZPYWVlNGFqZTZCSzFwTnM2Z0JEaVloNHNnOFEv?=
 =?gb2312?B?K0ZrVHZpcHE3YVJpYXN6UWNxRlA1UnE5MVB5c016UGhkSnhOUmRNYmFLNEZi?=
 =?gb2312?B?ZlI3YnFPc3kvWUhYdXM2UjI0KysvZk9xR0NiUjJ5UnVvMmM5ZFllcFhHdFJp?=
 =?gb2312?B?ZDI5OHJsWExneDNEbFZZY3NnOXZwRDFadDBMeXM1RkM0TWdScmJ4dU9odUFJ?=
 =?gb2312?B?YXpvQmR5S2Rrb3pRVVBic2toelFLV3VKNXkzNlFIa0x0d2h2UEZBNWFiOEVU?=
 =?gb2312?B?WWVLWTFSK1dEYnRCYmpDWlRoVkZya2FyRm9URGd5N2Q2RndTaWRETW81NHBp?=
 =?gb2312?B?ei96Nzh4RWI3Wm5uaDlJdjdJYi9yRlNFKzV3RExRMlZibUl1Z1Y3MHkycWFl?=
 =?gb2312?B?VVhoNjhoTEN2NzI0WHdJUnpKWkxYd0phM0VmdE5KUGI5TVJFUUlOMTI3OU1K?=
 =?gb2312?B?SEw5c1YybllpZ1pxMkxxOGlTaHNibWY3SEkxYjZWVFNBbDNmaUxvNlpyS21r?=
 =?gb2312?B?Z0M3WjcvSTIxQ01GT1JNOFpJTnRZcTdwRlh2cWh0MUk2WFh3NUc0VE4yeVB1?=
 =?gb2312?B?N1hwVmU0WHdoa1lVNmhBZ1hzajRXUUlVeFJNOFNza0dNY1o5eW4yclNZZUFa?=
 =?gb2312?B?dFVSZDVLLzQwVjhMdmFqVEQvNk1yeGJRdUFzb1BMVmJFQTRFZ0EzVlBMZ2No?=
 =?gb2312?B?WjVaM01VbC9rRnVYQjlhZXNXMDR6djR2alZEdDR3M2U2aGJhSnl3YWpoeCtv?=
 =?gb2312?B?cWhmUlk5R3F0Rm8zcTJQd2NBS0ducjI2SWt3U1ZSaEhSVXkxR1k1dGhOUEF3?=
 =?gb2312?B?R1ZuY3pBcGI0cEhHaXJNTVgvQ2xHRWNJMi9VWmI1aXkwMUJqZzdyQVhwN3JK?=
 =?gb2312?B?ZW9UM3hQTWlJZk9HQnMyWHErcFNKOCtsR2FkdE8rMWZteHJreHZtU1N0VS84?=
 =?gb2312?B?ZlU3YUI4OFZtVC96MURIUE82enRsZ3lwazVmd0ZnNEx0czMzK0VZM3JuUW5R?=
 =?gb2312?B?MHVFUTdCV2lHckxubTRWKzQzWm0razl6UEI3L0l5WHRJQ0FPbGJrRWpTQ0NF?=
 =?gb2312?B?L3dRSjRYTnJzZHVRSnVMcGJLOWhHSkxYWThLK2ZMaGNpdEYyV3A5QnhxZDRn?=
 =?gb2312?B?Vm52Uzdmbm9wU09mQUxucW1KWnJvRThKbUVIOHBnR21lUjQvSHA0SlBiQzZv?=
 =?gb2312?B?eE93Yk1Jbnh3cCtjSUgyQ3dobTRjdGRwdUJtRlhJMjJHOVJOUTFLekZkVEtF?=
 =?gb2312?B?MGhoUEZTb1VldUZ4cjF2NysvcE9oQjlNdCtMU3lQTVB6cXQ4aUcvamRoQWFN?=
 =?gb2312?B?clo0bXMrWTNsWXNuM0tzTjFKUlJEUHdwQnFwSGx5dERRMXdYSDhIRkxIbkJj?=
 =?gb2312?B?NzdmcThieDJkMENybnZxakpTcUNuV0tiSS9IRTU0UHRONTY0Q2lsdERwVXUy?=
 =?gb2312?B?MlRWSjlIcG1ZdkxDYkJCYkIyelljd2hEanJ4Mld1aHBJSk1zVzg5UGNsVzQr?=
 =?gb2312?B?cmVxbTZUaXFlWTRDYlBncFEyVDFpdDdPZXFHaVg1TGQySkwrTXc3VHcxSlY5?=
 =?gb2312?B?WEd4YVJ3Z0xEQko3OVl6cWF6NkgvUEhWVTlEVU51K3E5TjV3LyttcXhhNzUr?=
 =?gb2312?B?V3A1UUVibHB6ZWd2Z2wrdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3JwTmthMEFic3ZPZFNiTE9sTFJvZXU5VndteGYzZEplekhsY0MrdmJlQ0xG?=
 =?gb2312?B?b3VZcEJsUXB4TXFYK1hlbkIzMThSY3JReFRJWnNLMExUbWRSY3pHWEJYZ2hj?=
 =?gb2312?B?TDdKRGxiaEFRVFpLK09FRERyUC9MU3ZsbUw5YUYvTFFkdTFjR3VRdDZFeDJ3?=
 =?gb2312?B?Vm41NkFwM3NQTW9hS2V2cllRRXJvNDR1OVJrczl5UFY0cEh6b1hwM29ESkRT?=
 =?gb2312?B?cFF1WkRwT1hTMVVJcW1MZjlKK2ZSTllFMy8vb1EzU1JNU1Z3V0tlZFd2V3lC?=
 =?gb2312?B?OVo2ZVpPaWc4M28rTEhQc2dYOXF0YnhEYXFEbTg5NHRmOWp6eVNOOW02TjZu?=
 =?gb2312?B?aFd4MUxMNTlJNEgvb29zZVpUTHNqL2xEbEl0NkM0bjRHNnBZNTlNcVV6OGRX?=
 =?gb2312?B?RHgzaDIvRFlaandxWGFOSGhvaGp5cVozQzFPSG5DT2dWVlIrc1Z2QWZHVXp0?=
 =?gb2312?B?M2FoUDJlcWtJcGZ5YUlzQXNmblBkNVFrREUrY3IzclJYUC8xTHp0eUdNSzRJ?=
 =?gb2312?B?cVNKbFlSbXpscUNtNGVMSEN2WjZaR3pzYU9Ya0t2aWRiSmI5Q0VJdUhJQ0hN?=
 =?gb2312?B?UjlzQ0R6dGhOOG1DNVJ5NUlrS1VDeHM1TGwyQmRRMWhrZVRLTS8wVmtQYVVr?=
 =?gb2312?B?RmhUYmt5ZkZFcFI1V2lnelZVZGpZN2RaVEwxemlJcHh0VVNhY3F4dS91VVM0?=
 =?gb2312?B?c3ZJZ2ZKOExSWVd3ZmpWSUgyclh3eVR1SGxXaXJVem1MSFlERVNZd1dVU3Vm?=
 =?gb2312?B?cmJscWMzOTYrNEhHWHpnYXJYRHBlNG5IWlhiUGJUVEN6RlMxUXhORGlyWW5n?=
 =?gb2312?B?Ym5ja1YrOEJvNStHOTZDRVZKa0JURzg3Yk9UWmNaSkFBUnhjSGxCLzJMYlhl?=
 =?gb2312?B?akpFNWliNndhVXlYOHBka2pEMG9PZ1BQOWxkWkx2REIrTzV1bEZLQ05xRGRD?=
 =?gb2312?B?R2NGamlPUnJRN2dNSUZwNXcrRTN2a3gwWVRGZmJGczBDcjlxZytLek01M29n?=
 =?gb2312?B?NVF4VkErTm5zcTBmemFhMUNrcTJySTByWXozUm04bkdwWEh6MEFDY3ZzdU1j?=
 =?gb2312?B?b0FUV0l4RHZPUkxMeEYrcUN4TDhoT0J3bFFXZms1Qk5UeE9SM2dZanVad2x5?=
 =?gb2312?B?Tm9JMG9YeVVlcjZlWjVUdXVhUGU2UXBnclhGeWNUZWgzeW5xK1NFNU5YQmVs?=
 =?gb2312?B?RTc1djRUV1EyeitVeHg3aGFqZjE0QWdVUUZMTHdOSGJGdXM2R1J0UWpZSGRs?=
 =?gb2312?B?VTB5emE4RVE0L09nczRMZW9IK1FXOFo0SkVsWmFJRTZkMDZ4blNENTNYT1Ri?=
 =?gb2312?B?RU1aOUowbUJYK2lTc0x2cTBublFlSytleTlWQ2RUVEtMZ0Vzd1Qxdm90RTJG?=
 =?gb2312?B?L3Job3ZNMXpTQXlJdW16RGdqeXorbXVqU0pyaG9WQ1BkOXZ5MlRYL0dyd3RX?=
 =?gb2312?B?QVByV21BZmsxOVA3eDR6WmtHblpqWTllOVpMVytLSkNNZTRsc1ROeGJJVjND?=
 =?gb2312?B?Um9IZ1Noc2hPR2dzL0M1clZCcHpjVFBTa1ZJR2kvaFdXc3dPbFhFa3hkdFVQ?=
 =?gb2312?B?b2NiaTRYTHViWTVYQXlVNlR0YWxWUmphSXlMRDlrQmZSVE5oL1pSTmxlMlpr?=
 =?gb2312?B?SGZZeVdhdExKT1hTK3liUDRIRkhxcDBJMkg5VmhNVTdkWGx1djZGL2xtY1Jz?=
 =?gb2312?B?U0I4QkF4MVo0anFXVFpDVTRlOUJQNTNoRjhPNWFpbkt6c0ZuU1RZdno2Wm81?=
 =?gb2312?B?Z0tYZUh4MVlyR25jU1U3clNYNzdOQkUyM3BieUVlTU11ZWNGd2JveWZzVnhM?=
 =?gb2312?B?S1EzaEo3cFlUeEJMcW10N1FwUkhUL045VDhhZklRNXRGb1RWejFjUmxheUxv?=
 =?gb2312?B?SFNmTFNPRUtKa2hVdzAzRVJiMFNmbnlCR0IyTzNDLzMzVWFuTW9ERldNbE0r?=
 =?gb2312?B?Sk9FT0w3VzhuQXdOZnl5MG1nNzVUanYyVldIeXBSYTl1eHFQNVVmTXV6S1da?=
 =?gb2312?B?T29oMFVYZkdQKy9YYnBLWFdEaVRBaEJmZmNYaGZkempPbHdXUVVYdWFOVXQ5?=
 =?gb2312?B?bXRkSGJEYURhaGtpcS9zNkJQc2FCTlEzd0tmU1FQWUdHRDVicC9PckVZVzY0?=
 =?gb2312?Q?GkPY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c07a9bae-6d01-4fd5-4909-08dce8612a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 12:52:00.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tY880FWkk64+5qwaWwcF9Sqy58mV4/AX1y8GMITmItunroxNavfvv7wvalk3i5R5TyEvUkEmGL4Yf3HcEm6ydA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7840

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMNTCOcjVIDE5OjM1DQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IENsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsNCj4gYXN0QGtlcm5l
bC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBoYXdrQGtlcm5lbC5vcmc7DQo+IGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVs
Lm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgcmthbm5vdGhAbWFydmVsbC5jb207IG1hY2ll
ai5maWphbGtvd3NraUBpbnRlbC5jb207DQo+IHNiaGF0dGFAbWFydmVsbC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyBuZXQgMi8zXSBuZXQ6IGVuZXRjOiBmaXggdGhlIGlzc3VlcyBvZiBY
RFBfUkVESVJFQ1QNCj4gZmVhdHVyZQ0KPiANCj4gQ29tbWl0IHRpdGxlIHN0aWxsIG1lbnRpb25z
IG9ubHkgWERQX1JFRElSRUNULCB3aGVyZWFzIGltcGxlbWVudGF0aW9uIGFsc28NCj4gdG91Y2hl
cyBYRFBfVFggKGFuZCBvbmx5IG1ha2VzIGEgdmVyeSBtaW5vciBtZW50aW9uIG9mIGl0KS4NCj4g
DQo+IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBoYXZlICJuZXQ6IGVuZXRjOiBibG9jayBjb25j
dXJyZW50IFhEUCB0cmFuc21pc3Npb25zDQo+IGR1cmluZyByaW5nIHJlY29uZmlndXJhdGlvbiIg
Zm9yIGEgY29tbWl0IHRpdGxlPw0KPiANCj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMDU6MDM6
MjZQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gV2hlbiB0ZXN0aW5nIHRoZSBYRFBfUkVE
SVJFQ1QgZnVuY3Rpb24gb24gdGhlIExTMTAyOEEgcGxhdGZvcm0sIHdlDQo+ID4gZm91bmQgYSB2
ZXJ5IHJlcHJvZHVjaWJsZSBpc3N1ZSB0aGF0IHRoZSBUeCBmcmFtZXMgY2FuIG5vIGxvbmdlciBi
ZQ0KPiA+IHNlbnQgb3V0IGV2ZW4gaWYgWERQX1JFRElSRUNUIGlzIHR1cm5lZCBvZmYuIFNwZWNp
ZmljYWxseSwgaWYgdGhlcmUgaXMNCj4gPiBhIGxvdCBvZiB0cmFmZmljIG9uIFJ4IGRpcmVjdGlv
biwgd2hlbiBYRFBfUkVESVJFQ1QgaXMgdHVybmVkIG9uLCB0aGUNCj4gPiBjb25zb2xlIG1heSBk
aXNwbGF5IHNvbWUgd2FybmluZ3MgbGlrZSAidGltZW91dCBmb3IgdHggcmluZyAjNiBjbGVhciIs
DQo+ID4gYW5kIGFsbCByZWRpcmVjdGVkIGZyYW1lcyB3aWxsIGJlIGRyb3BwZWQsIHRoZSBkZXRh
aWxkIGxvZw0KPiANCj4gZGV0YWlsZWQNCj4gDQo+ID4gaXMgYXMgZm9sbG93cy4NCj4gPg0KPiA+
IHJvb3RAbHMxMDI4YXJkYjp+IyAuL3hkcC1iZW5jaCByZWRpcmVjdCBlbm8wIGVubzIgUmVkaXJl
Y3RpbmcgZnJvbQ0KPiA+IGVubzAgKGlmaW5kZXggMzsgZHJpdmVyIGZzbF9lbmV0YykgdG8gZW5v
MiAoaWZpbmRleCA0OyBkcml2ZXINCj4gPiBmc2xfZW5ldGMpIFsyMDMuODQ5ODA5XSBmc2xfZW5l
dGMgMDAwMDowMDowMC4yIGVubzI6IHRpbWVvdXQgZm9yIHR4DQo+ID4gcmluZyAjNSBjbGVhciBb
MjA0LjAwNjA1MV0gZnNsX2VuZXRjIDAwMDA6MDA6MDAuMiBlbm8yOiB0aW1lb3V0IGZvciB0eA0K
PiA+IHJpbmcgIzYgY2xlYXIgWzIwNC4xNjE5NDRdIGZzbF9lbmV0YyAwMDAwOjAwOjAwLjIgZW5v
MjogdGltZW91dCBmb3IgdHgNCj4gPiByaW5nICM3IGNsZWFyDQo+ID4gZW5vMC0+ZW5vMiAgICAg
MTQyMDUwNSByeC9zICAgICAgIDE0MjA1OTAgZXJyLGRyb3AvcyAgICAgIDAgeG1pdC9zDQo+ID4g
ICB4bWl0IGVubzAtPmVubzIgICAgMCB4bWl0L3MgICAgIDE0MjA1OTAgZHJvcC9zICAgICAwIGRy
dl9lcnIvcw0KPiAxNS43MSBidWxrLWF2Zw0KPiA+IGVubzAtPmVubzIgICAgIDE0MjA0ODQgcngv
cyAgICAgICAxNDIwNDg1IGVycixkcm9wL3MgICAgICAwIHhtaXQvcw0KPiA+ICAgeG1pdCBlbm8w
LT5lbm8yICAgIDAgeG1pdC9zICAgICAxNDIwNDg1IGRyb3AvcyAgICAgMCBkcnZfZXJyL3MNCj4g
MTUuNzEgYnVsay1hdmcNCj4gPg0KPiA+IEJ5IGFuYWx5emluZyB0aGUgWERQX1JFRElSRUNUIGlt
cGxlbWVudGF0aW9uIG9mIGVuZXRjIGRyaXZlciwgd2UgZm91bmQNCj4gPiB0d28gcHJvYmxlbXMu
IEZpcnN0LCBlbmV0YyBkcml2ZXIgd2lsbCByZWNvbmZpZ3VyZSBUeCBhbmQgUnggQkQgcmluZ3MN
Cj4gPiB3aGVuIGEgYnBmIHByb2dyYW0gaXMgaW5zdGFsbGVkIG9yIHVuaW5zdGFsbGVkLCBidXQg
dGhlcmUgaXMgbm8NCj4gPiBtZWNoYW5pc21zIHRvIGJsb2NrIHRoZSByZWRpcmVjdGVkIGZyYW1l
cyB3aGVuIGVuZXRjIGRyaXZlcg0KPiA+IHJlY29uZmlndXJlcyBCRCByaW5ncy4gU28gaW50cm9k
dWNlIEVORVRDX1RYX0RPV04gZmxhZyB0bw0KPiANCj4gKC4uIGRyaXZlciByZWNvbmZpZ3VyZXMg
QkQgcmluZ3MuKSBTaW1pbGFybHksIFhEUF9UWCB2ZXJkaWN0cyBvbiByZWNlaXZlZCBmcmFtZXMN
Cj4gY2FuIGFsc28gbGVhZCB0byBmcmFtZXMgYmVpbmcgZW5xdWV1ZWQgaW4gdGhlIFRYIHJpbmdz
Lg0KPiBCZWNhdXNlIFhEUCBpZ25vcmVzIHRoZSBzdGF0ZSBzZXQgYnkgdGhlIG5ldGlmX3R4X3dh
a2VfcXVldWUoKSBBUEksIHdlIGFsc28NCj4gaGF2ZSB0byBpbnRyb2R1Y2UgdGhlIEVORVRDX1RY
X0RPV04gZmxhZyB0byBzdXBwcmVzcyB0cmFuc21pc3Npb24gb2YgWERQDQo+IGZyYW1lcy4NCj4g
DQo+ID4gcHJldmVudCB0aGUgcmVkaXJlY3RlZCBmcmFtZXMgdG8gYmUgYXR0YWNoZWQgdG8gVHgg
QkQgcmluZ3MuIFRoaXMgaXMNCj4gPiBub3Qgb25seSB1c2VkIHRvIGJsb2NrIFhEUF9SRURJUkVD
VCBmcmFtZXMsIGJ1dCBhbHNvIHRvIGJsb2NrIFhEUF9UWA0KPiA+IGZyYW1lcy4NCj4gPg0KPiA+
IFNlY29uZCwgVHggQkQgcmluZ3MgYXJlIGRpc2FibGVkIGZpcnN0IGluIGVuZXRjX3N0b3AoKSBh
bmQgdGhlbiB3YWl0DQo+ID4gZm9yIGVtcHR5LiBUaGlzIG9wZXJhdGlvbiBpcyBub3Qgc2FmZSB3
aGlsZSB0aGUgVHggQkQgcmluZw0KPiANCj4gdGhlIGRyaXZlciB3YWl0cyBmb3IgdGhlbSB0byBi
ZWNvbWUgZW1wdHkuDQo+IA0KPiA+IGlzIGFjdGl2ZWx5IHRyYW5zbWl0dGluZyBmcmFtZXMsIGFu
ZCB3aWxsIGNhdXNlIHRoZSByaW5nIHRvIG5vdCBiZQ0KPiA+IGVtcHR5IGFuZCBoYXJkd2FyZSBl
eGNlcHRpb24uIEFzIGRlc2NyaWJlZCBpbiB0aGUgYmxvY2sgZ3VpZGUgb2YNCj4gPiBMUzEwMjhB
IE5FVEMsIHNvZnR3YXJlIHNob3VsZCBvbmx5IGRpc2FibGUgYW4gYWN0aXZlIHJpbmcgYWZ0ZXIg
YWxsDQo+ID4gcGVuZGluZyByaW5nIGVudHJpZXMgaGF2ZSBiZWVuIGNvbnN1bWVkIChpLmUuIHdo
ZW4gUEkgPSBDSSkuDQo+ID4gRGlzYWJsaW5nIGEgdHJhbnNtaXQgcmluZyB0aGF0IGlzIGFjdGl2
ZWx5IHByb2Nlc3NpbmcgQkRzIHJpc2tzIGENCj4gPiBIVy1TVyByYWNlIGhhemFyZCB3aGVyZWJ5
IGEgaGFyZHdhcmUgcmVzb3VyY2UgYmVjb21lcyBhc3NpZ25lZCB0byB3b3JrDQo+ID4gb24gb25l
IG9yIG1vcmUgcmluZyBlbnRyaWVzIG9ubHkgdG8gaGF2ZSB0aG9zZSBlbnRyaWVzIGJlIHJlbW92
ZWQgZHVlDQo+ID4gdG8gdGhlIHJpbmcgYmVjb21pbmcgZGlzYWJsZWQuIFNvIHRoZSBjb3JyZWN0
IGJlaGF2aW9yIGlzIHRoYXQgdGhlDQo+ID4gc29mdHdhcmUgc3RvcHMgcHV0dGluZyBmcmFtZXMg
b24gdGhlIFR4IEJEIHJpbmdzICh0aGlzIGlzIHdoYXQNCj4gPiBFTkVUQ19UWF9ET1dOIGRvZXMp
LCB0aGVuIHdhaXRzIGZvciB0aGUgVHggQkQgcmluZ3MgdG8gYmUgZW1wdHksIGFuZA0KPiA+IGZp
bmFsbHkgZGlzYWJsZXMgdGhlIFR4IEJEIHJpbmdzLg0KPiANCj4gSXQgZmVlbHMgbGlrZSB0aGlz
IHNlcGFyYXRlIHBhcnQgKHJlZmFjdG9yaW5nIG9mIGVuZXRjX3N0YXJ0KCkgYW5kDQo+IGVuZXRj
X3N0b3AoKSBvcGVyYXRpb24gb3JkZXJpbmcpIHNob3VsZCBiZSBpdHMgb3duIHBhdGNoPyBJdCBp
cyBsb2dpY2FsbHkNCj4gZGlmZmVyZW50IHRoYW4gdGhlIGludHJvZHVjdGlvbiBhbmQgY2hlY2tp
bmcgb2YgdGhlIEVORVRDX1RYX0RPV04NCj4gY29uZGl0aW9uLg0KDQpPa2F5LCBJIHdpbGwgc2Vw
YXJhdGUgdGhpcyBwYXRjaCBpbnRvIHR3byBwYXRjaGVzLCBvbmUgaXMgZm9yIEVORVRDX1RYX0RP
V04sDQp0aGUgb3RoZXIgaXMgZm9yIGRpc2FibGluZyBUeCBCRFJzIGFmdGVyIHRoZSByaW5ncyBh
cmUgZW1wdHkuDQpUaGFua3MuDQo=

