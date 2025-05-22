Return-Path: <bpf+bounces-58727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F1AC0EC9
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96C41881F98
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294828D85E;
	Thu, 22 May 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PiXIY6gg"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022096.outbound.protection.outlook.com [40.107.200.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECD1F94C;
	Thu, 22 May 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925478; cv=fail; b=YYnRB+HB8w+B/0oXyyRWaS/u8sc+UShltKVaQn+j6V6/K7f2yxkUjszYmuz3bfAH0gyQMqMmZfcBjHf/RUNHtBteiqlzjoPPaBwt7V5uK55PnnJ3QkHQriSH5IAVw0CqWbcqRESpLEU3ZLi7cD+Ig8oTdhU1yxoDq4O4UIi+KVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925478; c=relaxed/simple;
	bh=be//wkfbMLmNS2W9rEr4aHEwbqEUm1SzfC20rOY0AX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGO9CErDNhd1BAfDinQuaw6601Z093Pz41jsOcAioCrX11w04/grREk/tu2WhfBrnZ50Jcxk5uT/9WSNKK2aJZX2Tah3VdB8mJ5HWVnelSxOCV6RcsmytUUHQw098RIiFOk7nvLJCG9Tkk0DTdPih/QphTCTv4BVRE5/Oe53Czw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PiXIY6gg; arc=fail smtp.client-ip=40.107.200.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbk2JlzvV3thnMdQkykS31XT73hKSZ6DhUDJBCeBygL9cplu1yNu6LVPiWrqThVAT1TRgQ6ssvxCVykkhqCb00WgSSTg7XOOFepXpcKxYqhYBVg6E9xDj31LFRUZzQFEvzl6Rw0YG0IaiEFvcz+pxZqOIz89RTTmxjoYaof3KH9EY8Pdr8e3M9h8VbCdik/yaajj0EGZOGYeD+qdriqYRkBBqT94y4O/QXxmU1eeg0kzCunfrDuDqMiXpbtFfyNxJ5DE6OTwjqdKPglXlCTCwfhKu67QPFMgrnlThTLZcMtKArtBbEXspH43zjZfctFYawP3s7lrlQbwemUgCRPxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be//wkfbMLmNS2W9rEr4aHEwbqEUm1SzfC20rOY0AX0=;
 b=ldxBrKGb0TQPpARgtwTV8vSPf/lgnmMsaTpL1dFxjZsMdo0QP044NQcNzsC7A2cILmjfzbwA1qEAoUvMTBczasomZsRmREv/U4t7bGO+BirqTOTDThAaP0OCZJNb/wqcs4Chrxgo14FMOz27o7JCGQCiCVGfPr4H+pFvYlSe5na/jaqjymqYK9D6/jPC8ErzUtWKq6C3T9M3Qegs879ZD8EbYowDHHRJRSHHz0rhSxW6yMeSD+HLynUQF5rLX/qZGJTArqcGZlt0jVe+3jtQsNJrxMBlqR61XW+2yS3W2LDzgLjg7925HNafeYJh+17zqODBoOpoDTgdInSkgwE6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be//wkfbMLmNS2W9rEr4aHEwbqEUm1SzfC20rOY0AX0=;
 b=PiXIY6ggTFr+f3mnrSBttb0gyuRkxVFRRCLX8gB2Is64mZaC8v2i7MtbCeXByftHToUeuHDhWbYiLadVLFDWZLEsDMwDgyx39fiTULkpu0+SyXJMvYicTX5WeGahbtnalq6ziqVgJvspnBB3c05SfQhMIh/ADIbmW3kmbyVLB3Y=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by IA1PR21MB3545.namprd21.prod.outlook.com (2603:10b6:208:3e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 14:51:12 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 14:51:12 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Konstantin Taranov
	<kotaranov@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v2] net: mana: Add support for
 Multi Vports on Bare metal
Thread-Index: AQHbyNn8vVCGUyGze06AyBI1ln70urPdIEiAgAAzRTCAAT2HgIAAHFMAgAAMutA=
Date: Thu, 22 May 2025 14:51:11 +0000
Message-ID:
 <MN0PR21MB3437196CFAF4574776862F6ACA99A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
 <20250521140231.GW365796@horms.kernel.org>
 <MN0PR21MB34373B1A0162D8452018ABAACA9EA@MN0PR21MB3437.namprd21.prod.outlook.com>
 <20250522120229.GX365796@horms.kernel.org>
 <5470f2d2-d3cb-4451-b8e8-5ee768ed9741@redhat.com>
In-Reply-To: <5470f2d2-d3cb-4451-b8e8-5ee768ed9741@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17c0f31d-32a1-436e-bef7-37859d0b05c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-22T14:29:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|IA1PR21MB3545:EE_
x-ms-office365-filtering-correlation-id: a06f2559-4069-4012-f721-08dd99401836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVNjWkFya1c1QmgwNlBLSEQrTXFBemk3L0YyM255ZVBSeDhaY3JqUVNKOVlS?=
 =?utf-8?B?NGkvK3NwT0ZBUTFGRDRtalUxWXBwNmQ0eGtld0ttMEhzK1FubTFlbVNBbUJ4?=
 =?utf-8?B?MXgzNW9GS1hSaU5ESU1KbWdYZmlQaWFiNjc1cy9rVUhoOWp0MituNlhCYU9w?=
 =?utf-8?B?ZnB6OXhjaHd0U0g2d3BQMWEwS1FCQ2JZZjUyYmhFMEU1WllKeStka2tYZG5a?=
 =?utf-8?B?cDNLNnJlZ2N2Um91K2t4aEF1LzJEL0k0bTJtc1V5dVNTTU9PNjZwakowKzlK?=
 =?utf-8?B?VVpUSDV1SGJWQ1VUNFZ3RzZCejVVNUZIaTNzLzYyOEhYWmxGdVVQTkZUMmFm?=
 =?utf-8?B?TEZ2T2N4U2lGRE9tQVNOc011MS9kWVpiZUtWRlcrZC9IcS9YUUFRRldtVm5K?=
 =?utf-8?B?M01ZZ2tDZmNVMmFrS2RoTTVCeXlkK2NYLzVwTk9VMjV4TDhCMElSaFROcHFV?=
 =?utf-8?B?WTRibHhKOStiMDh4U0tXUk5JSjRXUENDbERqdDdvSW1lWVMxVlRibThmelhE?=
 =?utf-8?B?RG9BRGhna2RBYTVZQmRCdWZROWtGNzNucG9IaWo5cTVMcTlrQWd3SkIvVFNG?=
 =?utf-8?B?SGZEcldrQnpqRElITFNyaFB2dnpibHBHZ2VhSzRSUEx3cTBUV1RvTThQYjAz?=
 =?utf-8?B?MC9IM2NFY3BOTHlGanRZZEZYeEtkNy9wa21PZ2llaGFYbTlOZm0xYUoyU0hK?=
 =?utf-8?B?aFp5ZzVVSHJsV3J0eFJFbDRralcrUHNRVjdEbDE4ZXQxUmJnTWM5T0Fmcmhv?=
 =?utf-8?B?Z3BRV0NXQ0UxaEZuaERqeVp4K1AyR2ZYbnUrdElJeEIwNHF2eDlML0VKT3pE?=
 =?utf-8?B?SE5DNXFaZ0ZxUmdaZTRuQ0toQWF5NlpnemFIMmJhRG1hTzVERHgva3J2S3NL?=
 =?utf-8?B?MXQ4UHFKdi9WMm9wSFZhT2xNTEhpUVBQaW5qbnM1b21EZk5aNDlpMGlLVnUz?=
 =?utf-8?B?cWVITHdjeDF6SXJzY1dwNDM4RnF5dVcyT0wvZW9SU29oZXd6M1RSQ2xoaDRI?=
 =?utf-8?B?Q015dEc1SXdXZFRTSFVQWmZBVm5FNk4rMWYyL214QTMzaVluZjlmNTF5eXFI?=
 =?utf-8?B?TThsT20vbG1PdkgyUU8xdjFYUkluMUkrZVZnanNwNGZSbjl2U09IcFkxZnB6?=
 =?utf-8?B?cWk0ZEtmRWs0Z0RRWnd5QUs5a2Z4S1FKVGx3cVFHdzNMdUlXbit5VVhkVUV2?=
 =?utf-8?B?Kys5MWY2SWNpa2VkM2hTd3dFejdUaEVsOUViYVFWZFJaTjQxL043REtNQldz?=
 =?utf-8?B?NEFla0ZCNk5rYWVNTUVmME9WNHBDV05XbWJwNEFva0ZPRU9CVWpKRVlBMUI0?=
 =?utf-8?B?RWJ4aEJzMWFBZ0ZDMmhGMW45Z2MzYWlNU0UyYWtWWUJjL2k5Zm5Tb1R3SWtO?=
 =?utf-8?B?ejVRVmFoQVFFZkE0WXpxUnRkSWxZNWpaSEVqdGl4QkhINGlEOWJvVFNFelJW?=
 =?utf-8?B?YUtCM1R0cGxkQTY5VDd3cTVOQ0hvK3pYWlpyNE94SldHanFpWkczSklRL2ZS?=
 =?utf-8?B?aWdZL0FoOGE4OXhwSVBoaWZnMmxvd0NVYTBSNjdrRHdLdDYvcFpBWDYxZVUw?=
 =?utf-8?B?YjBrZ2VoOEl1dmtrV2drMTczQjVWQkxJaG5qQ0dCbmR3ay84TlN4MmNiUWwx?=
 =?utf-8?B?WEZnaDhkSTRCd2dUeTZtenlJNWcreXdYWUd0Z1FvZ09RRjYzcUVkUFA2Yndq?=
 =?utf-8?B?K3dMc1JYZ01zcDJaeGg1c0swUnlIMTZzeUIzN3VvNnRuUEZZcjEyZjdwdXN0?=
 =?utf-8?B?S3FzWWVma1JrOUQvTTRyUklFQTB5WjhZVW5jWEk2Y3NHRjRwekNmdlEwYlFU?=
 =?utf-8?B?ZEVqT1lkZHNVOGM3NmQyUi95VTNTUUtZVElxdktGWGNoVFQ4WGs2WFIwZUlB?=
 =?utf-8?B?Qy8vQUpRYjNsNnhyUFlZeHFRRjV2blFLSHlCbmJLTU9xOE8wVW9xSzlBWTVt?=
 =?utf-8?B?c3ZMUDJ2eWZ6T3QwRy9PTXVRL2RVRFBpaDd1NjRYdEJTMEVGT2ZXcWJWT1pG?=
 =?utf-8?Q?U73W7gjvRN6Mahtp6xAXvDKufEcoow=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmhxbmFaZGpMeGptRWVIVks3VUV6WVVFRHY3aHpqaW1BdHNvdlA2WDJmZHRY?=
 =?utf-8?B?Z3BQakNWZ2RzVnAyZStsRzFnT2V5WDN5RzFVU0JJbEpENnVFVTg4TjRwTWkx?=
 =?utf-8?B?bm5NV1dlNDdoUEhzS3hhWDg0eEFpbkQ2NTJNZTdrMHoralJpKzZiMzVRdjF5?=
 =?utf-8?B?YUY5REhBcmlEL2VhN1F0OGExRzMvU0N0M1YrS0xHK01hbytPSTg3dUVmbEtw?=
 =?utf-8?B?WHZScEtycGkwa2l4V1FJMWZHUStlQk5vSmZSQWpWa2sxUEYwZldQLy93ZEEx?=
 =?utf-8?B?OHBzRVBCUG5WS09TVUpyOVh1M2p5cHVxa3prQnZaanJDZ2VOZDVOSGcvTkw4?=
 =?utf-8?B?am1rUHBUL1BKb25HeDBiTG1mWE1iQWRROVBGZGFUUTlsSVBURXBHd1lsWDRZ?=
 =?utf-8?B?K0Qrd3UySHdlYlhZYUI5QStjdFg0bmI1NGd4QVNTMzMzYVNLMlZ3SGIxL1ZZ?=
 =?utf-8?B?WlVNcWpMUVB5eE5pQWh1NGU4WVk2Y05hMkh3bkhka3NjVkQvUXFpYzAyb1Qw?=
 =?utf-8?B?aGIxbVV3anhMb2lPc2w1VU1tZm5VZE8rY2JVSUxwL1hGQ3l3ZHV3UDFzUWtQ?=
 =?utf-8?B?YjVhcEY4K053RC9TMCtIdGFCTjBDQWdiVkpJSjJkMEYzUWh0MjljenRoQ2k1?=
 =?utf-8?B?bHlRVjk2dXpaeTM4RUNHcWVwSU00RVB5NVl4UUFQMElYSEU4cUY3SDZVNDJh?=
 =?utf-8?B?RHpES0VkMUZlVGhzaG52UjYyU0svZlc0b0xOdzlaS1NpdDY5L2Y2dVdXOEN2?=
 =?utf-8?B?S3RvVlVTWDQ1aFVuMmozeGhwUTRIS2RIMWNSbkE3bzgzRjZaV2lNYk9MZTVY?=
 =?utf-8?B?NmVmV1UvL05YTytSVE0ybGdhNld5OHBiaUJZcU9KNU11OVJ1YXRXMWRXZEQx?=
 =?utf-8?B?R1ZmRThuZFNPV3lESmhjWE1vRjNrSDRzUWJNZTMwNFFucCtZWWl0OVM1V2pT?=
 =?utf-8?B?S1JsRXBMOFR3WTMwWjVUYWJhWlY2Z0JNbWhKTmkzTEFuMTlRR0tXVFVNU2Nm?=
 =?utf-8?B?ZWl1QzVkZkFWdnd4YnY4YW1OVklJbXFzNkk4cjJVT1oxSEZmbWpBTUIyZlho?=
 =?utf-8?B?UGRPVFExMnlJanA1WFlMSWN5YklqdVZQMkJwSjJ1UzZBL0VINXFFU1F6RDh2?=
 =?utf-8?B?WDA4TnpNNUg3Z1M0RG5NbHVWRkFuU0lJV1pBQkdvQkJ6Q3pJM0ZFRlZWMmFE?=
 =?utf-8?B?dDNyUXNUR2ZDWTU1Ny8xaEZYRHRlcldjWFphNlZ4TjhkYW0vbXlnTU5RaC94?=
 =?utf-8?B?U0ZSSHlpN1FKY1pTWllybUJFWWlFNWhLZG16cm9aamdSSGdYNGQxNERTeDBZ?=
 =?utf-8?B?aUtlL25VWXBDbmZZUDRrZmd0TjNpRFIrSEpOYUdseEJISFJJRVYzSXo1bzFB?=
 =?utf-8?B?b3crWEw3bjM2NEEwdC9yZit2UEZ4T0gvWFpLYnpNM00xK240cEpPaUh5Uzgv?=
 =?utf-8?B?NVk1ZE9WZFQ5OC9ZdW1CV2RsYWRJUlN4S3Fvb1ZjcTBDdlRROUE5KzM3VDFZ?=
 =?utf-8?B?cEpnbmdlZVVlKzBML0huMTNRZ1ZOWHp0SUloK0cxa1ZXMXE1OTNuTGViU0Nz?=
 =?utf-8?B?cytVeFBXRE5rVjFTVHBCejQzaWYyb3ZnYTF3OFNTbVdvaE92dWx1V2YzbGlF?=
 =?utf-8?B?LzFvb0tjUitOM0VVYSsxV0N4eUtSOXY5bUx5VTRGV2JsbUJjY2dVWkFiL0Zn?=
 =?utf-8?B?ODI2ZHh4ZTB0Q2NVakZQNTJQZTRPbm9pdU12R1haZ1IyT1FFaWNiZEpTN3lX?=
 =?utf-8?B?ZUFJRDhQZGxaa3ZraGRWaUYvQlhoY0ZNWjQ5ZHhHMG9BTzk0YXRDeEJybkZD?=
 =?utf-8?B?SUdnZVdYa1o2TFVEODVuYlZKU0tON1NQQkRZMGwzaXllb3VyYjVoQ0FxV1NN?=
 =?utf-8?B?LzVidzVyd1Q2RHIvTEJwU0ttRWhXQWhxa0lqSlpqMXVQSFdrVGY5dTdlclBX?=
 =?utf-8?B?QkVLT0RzZzQvdXJSVWFJNzdrM0ZlYStTckxTOTNOV0dKK2NTSStrYkF1bmEz?=
 =?utf-8?B?QktMWmdRd2FiZUFmTWlKRlFsOU90OWJCcFZCZXlVK2VtbVhDRnFQSko2bHZx?=
 =?utf-8?B?LzN5Q3BCSzhlRUI5RVhRZGhVM0Z6dytwd1plWitEUllDVFA2Q2lXcmZHZzVo?=
 =?utf-8?Q?BW5vRIGmEEggMOgpz1cwqzxeM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f2559-4069-4012-f721-08dd99401836
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 14:51:11.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJMkRs3LYU1+ig3cqdFszKdzrAeHy5DtejBCUL+QKChrmr6pajLCpL9p/EZDUZpNjFLyb7wNVCCtQWx5TMWujw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3545

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDIyLCAyMDI1IDk6NDQgQU0N
Cj4gVG86IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IEhhaXlhbmcgWmhhbmcNCj4g
PGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQoNCj4gPj4+PiAgc3RhdGljIGludCBtYW5hX3F1ZXJ5
X2RldmljZV9jZmcoc3RydWN0IG1hbmFfY29udGV4dCAqYWMsIHUzMg0KPiA+Pj4gcHJvdG9fbWFq
b3JfdmVyLA0KPiA+Pj4+ICAJCQkJIHUzMiBwcm90b19taW5vcl92ZXIsIHUzMiBwcm90b19taWNy
b192ZXIsDQo+ID4+Pj4gLQkJCQkgdTE2ICptYXhfbnVtX3Zwb3J0cykNCj4gPj4+PiArCQkJCSB1
MTYgKm1heF9udW1fdnBvcnRzLCB1OCAqYm1faG9zdG1vZGUpDQo+ID4+Pj4gIHsNCj4gPj4+PiAg
CXN0cnVjdCBnZG1hX2NvbnRleHQgKmdjID0gYWMtPmdkbWFfZGV2LT5nZG1hX2NvbnRleHQ7DQo+
ID4+Pj4gIAlzdHJ1Y3QgbWFuYV9xdWVyeV9kZXZpY2VfY2ZnX3Jlc3AgcmVzcCA9IHt9Ow0KPiA+
Pj4+IEBAIC05MzIsNyArOTMyLDcgQEAgc3RhdGljIGludCBtYW5hX3F1ZXJ5X2RldmljZV9jZmco
c3RydWN0DQo+IG1hbmFfY29udGV4dA0KPiA+Pj4gKmFjLCB1MzIgcHJvdG9fbWFqb3JfdmVyLA0K
PiA+Pj4+ICAJbWFuYV9nZF9pbml0X3JlcV9oZHIoJnJlcS5oZHIsIE1BTkFfUVVFUllfREVWX0NP
TkZJRywNCj4gPj4+PiAgCQkJICAgICBzaXplb2YocmVxKSwgc2l6ZW9mKHJlc3ApKTsNCj4gPj4+
Pg0KPiA+Pj4+IC0JcmVxLmhkci5yZXNwLm1zZ192ZXJzaW9uID0gR0RNQV9NRVNTQUdFX1YyOw0K
PiA+Pj4+ICsJcmVxLmhkci5yZXNwLm1zZ192ZXJzaW9uID0gR0RNQV9NRVNTQUdFX1YzOw0KPiA+
Pj4+DQo+ID4+Pj4gIAlyZXEucHJvdG9fbWFqb3JfdmVyID0gcHJvdG9fbWFqb3JfdmVyOw0KPiA+
Pj4+ICAJcmVxLnByb3RvX21pbm9yX3ZlciA9IHByb3RvX21pbm9yX3ZlcjsNCj4gPj4+DQo+ID4+
Pj4gQEAgLTk1NiwxMSArOTU2LDE2IEBAIHN0YXRpYyBpbnQgbWFuYV9xdWVyeV9kZXZpY2VfY2Zn
KHN0cnVjdA0KPiA+Pj4gbWFuYV9jb250ZXh0ICphYywgdTMyIHByb3RvX21ham9yX3ZlciwNCj4g
Pj4+Pg0KPiA+Pj4+ICAJKm1heF9udW1fdnBvcnRzID0gcmVzcC5tYXhfbnVtX3Zwb3J0czsNCj4g
Pj4+Pg0KPiA+Pj4+IC0JaWYgKHJlc3AuaGRyLnJlc3BvbnNlLm1zZ192ZXJzaW9uID09IEdETUFf
TUVTU0FHRV9WMikNCj4gPj4+PiArCWlmIChyZXNwLmhkci5yZXNwb25zZS5tc2dfdmVyc2lvbiA+
PSBHRE1BX01FU1NBR0VfVjIpDQo+ID4+Pj4gIAkJZ2MtPmFkYXB0ZXJfbXR1ID0gcmVzcC5hZGFw
dGVyX210dTsNCj4gPj4+PiAgCWVsc2UNCj4gPj4+PiAgCQlnYy0+YWRhcHRlcl9tdHUgPSBFVEhf
RlJBTUVfTEVOOw0KPiA+Pj4+DQo+ID4+Pj4gKwlpZiAocmVzcC5oZHIucmVzcG9uc2UubXNnX3Zl
cnNpb24gPj0gR0RNQV9NRVNTQUdFX1YzKQ0KPiA+Pj4+ICsJCSpibV9ob3N0bW9kZSA9IHJlc3Au
Ym1faG9zdG1vZGU7DQo+ID4+Pj4gKwllbHNlDQo+ID4+Pj4gKwkJKmJtX2hvc3Rtb2RlID0gMDsN
Cj4gPj4+DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBQZXJoYXBzIG5vdCBzdHJpY3RseSByZWxh
dGVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBJIHNlZQ0KPiA+Pj4gdGhhdCBtYW5hX3ZlcmlmeV9yZXNw
X2hkcigpIGlzIGNhbGxlZCBhIGZldyBsaW5lcyBhYm92ZS4NCj4gPj4+IEFuZCB0aGF0IHZlcmlm
aWVzIGEgbWluaW11bSBtc2dfdmVyc2lvbi4gQnV0IEkgZG8gbm90IHNlZQ0KPiA+Pj4gYW55IHZl
cmlmaWNhdGlvbiBvZiB0aGUgbWF4aW11bSBtc2dfdmVyc2lvbiBzdXBwb3J0ZWQgYnkgdGhlIGNv
ZGUuDQo+ID4+Pg0KPiA+Pj4gSSBhbSBjb25jZXJuZWQgYWJvdXQgYSBoeXBvdGhldGljYWwgc2Nl
bmFyaW8gd2hlcmUsIHNheSB0aGUgYXMgeWV0DQo+IHVua25vd24NCj4gPj4+IHZlcnNpb24gNSBp
cyBzZW50IGFzIHRoZSB2ZXJzaW9uLCBhbmQgdGhlIGFib3ZlIGJlaGF2aW91ciBpcyB1c2VkLA0K
PiB3aGlsZQ0KPiA+Pj4gbm90IGJlaW5nIGNvcnJlY3QuDQo+ID4+Pg0KPiA+Pj4gQ291bGQgeW91
IHNoZWQgc29tZSBsaWdodCBvbiB0aGlzPw0KPiA+Pj4NCj4gPj4NCj4gPj4gSW4gZHJpdmVyLCB3
ZSBzcGVjaWZ5IHRoZSBleHBlY3RlZCByZXBseSBtc2cgdmVyc2lvbiBpcyB2MyBoZXJlOg0KPiA+
PiByZXEuaGRyLnJlc3AubXNnX3ZlcnNpb24gPSBHRE1BX01FU1NBR0VfVjM7DQo+ID4+DQo+ID4+
IElmIHRoZSBIVyBzaWRlIGlzIHVwZ3JhZGVkLCBpdCB3b24ndCBzZW5kIHJlcGx5IG1zZyB2ZXJz
aW9uIGhpZ2hlcg0KPiA+PiB0aGFuIGV4cGVjdGVkLCB3aGljaCBtYXkgYnJlYWsgdGhlIGRyaXZl
ci4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IElmIEkgdW5kZXJzdGFuZCB0aGluZ3MgY29y
cmVjdGx5IHRoZSBIVyBzaWRlIHdpbGwgaG9ub3VyIHRoZQ0KPiA+IHJlcS5oZHIucmVzcC5tc2df
dmVyc2lvbiBhbmQgdGh1cyB0aGUgU1cgd29uJ3QgcmVjZWl2ZSBhbnl0aGluZw0KPiA+IGl0IGRv
ZXNuJ3QgZXhwZWN0LiBJcyB0aGF0IHJpZ2h0Pw0KPiANCj4gQEhhaXlhbmcsIGlmIFNpbW9uJ3Mg
aW50ZXJwcmV0YXRpb24gaXMgY29ycmVjdCwgcGxlYXNlIGNoYW5nZSB0aGUNCj4gdmVyc2lvbiBj
aGVja2luZyBpbiB0aGUgZHJpdmVyIGZyb206DQo+IA0KPiAJaWYgKHJlc3AuaGRyLnJlc3BvbnNl
Lm1zZ192ZXJzaW9uID49IEdETUFfTUVTU0FHRV9WMykNCj4gDQo+IHRvDQo+IAlpZiAocmVzcC5o
ZHIucmVzcG9uc2UubXNnX3ZlcnNpb24gPT0gR0RNQV9NRVNTQUdFX1YzKQ0KPiANCj4gQXMgdGhl
IGN1cnJlbnQgY29kZSBpcyBtaXNsZWFkaW5nLg0KDQpTaW1vbjoNClllcywgeW91IGFyZSByaWdo
dC4gU28gbmV3ZXIgSFcgY2FuIHN1cHBvcnQgb2xkZXIgZHJpdmVyLCBhbmQgdmljZQ0KdmVyc2Eu
DQoNClBhb2xvOg0KVGhlIE1BTkEgcHJvdG9jb2wgZG9lc24ndCByZW1vdmUgYW55IGV4aXN0aW5n
IGZpZWxkcyBkdXJpbmcgdXBncmFkZXMuDQoNClNvIChyZXNwLmhkci5yZXNwb25zZS5tc2dfdmVy
c2lvbiA+PSBHRE1BX01FU1NBR0VfVjMpIHdpbGwgY29udGludWUNCnRvIHdvcmsgaW4gdGhlIGZ1
dHVyZS4gSWYgd2UgY2hhbmdlIGl0IHRvIA0KKHJlc3AuaGRyLnJlc3BvbnNlLm1zZ192ZXJzaW9u
ID09IEdETUFfTUVTU0FHRV9WMyksIA0Kd2Ugd2lsbCBoYXZlIHRvIHJlbWVtYmVyIHRvIHVwZGF0
ZSBpdCB0byBzb21ldGhpbmcgbGlrZToNCihyZXNwLmhkci5yZXNwb25zZS5tc2dfdmVyc2lvbiA+
PSBHRE1BX01FU1NBR0VfVjMgJiYNCiByZXNwLmhkci5yZXNwb25zZS5tc2dfdmVyc2lvbiA8PSBH
RE1BX01FU1NBR0VfVjUpLCANCmlmIHRoZSB2ZXJzaW9uIGlzIHVwZ3JhZGVkIHRvIHY1IGluIHRo
ZSBmdXR1cmUuIEFuZCBrZWVwIG9uIHVwZGF0aW5nDQp0aGUgY2hlY2tzIG9uIGV4aXN0aW5nIGZp
ZWxkcyBldmVyeSB0aW1lIHdoZW4gdGhlIHZlcnNpb24gaXMNCnVwZ3JhZGVkLg0KDQpTbywgY2Fu
IEkga2VlcCB0aGUgIj49IiBjb25kaXRpb24sIHRvIGF2b2lkIGZ1dHVyZSBidWcgaWYgYW55b25l
DQpmb3JnZXQgdG8gdXBkYXRlIGNoZWNrcyBvbiBhbGwgZXhpc3RpbmcgZmllbGRzPw0KDQpUaGFu
a3MsDQotIEhhaXlhbmcNCg0K

