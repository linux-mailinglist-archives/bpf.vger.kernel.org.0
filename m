Return-Path: <bpf+bounces-53430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48814A53E65
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C4A16E9BD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF6207A05;
	Wed,  5 Mar 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cbnaWweq"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023074.outbound.protection.outlook.com [52.101.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD620551B;
	Wed,  5 Mar 2025 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217121; cv=fail; b=a/IUKpFWazRBi8F7AX0sq3Xg7mVw49mssDH3ELjJMn24kUK18ExLq9ZmZ1wYntJMbnW2LtsP9rQgN2wiYLcQzs5k6FzvvLQaEfIsveyKKHfqnLMe0wzvCnGdNLtBU4D7NMLl2VRYal/vgN0cBt0OC6e6ghrcLkP3SHtny9hiI6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217121; c=relaxed/simple;
	bh=SUOapoQ2gVkAThNl0BzWJK9RXpHny3qvjON4wcwyXP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oM0qiAzXvsAkQlq9vgnz857OEPdOUWvKRvbqQfH7YgiD0RJ+9zM2374vpnFPfkcNQXonx3LhVLXnyXOJmnAx3U/urcW3/KrT2tg9lOUoVpumqGqjQqh0XYs/3gMpQ31qU+SIhUmVO5VhUIAEstSTAklGweXeYWCAQVrbvNwHd0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cbnaWweq; arc=fail smtp.client-ip=52.101.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcFzz8pkQQTpzZyy3bYg8qJ/gTIKTSmKr86NnEk/H7EQYzp9fzvnR/f0JaN+T0E3ujDPBXm4dswmCQuEDOXzS39gt9Naz3NlFlB0m2TVKMhTPRfiHIlI93gE5yzocmUxYV1Hb42GqMCe4gGJQl4FtS81DpPFm58bDNMYKDHkYa1a1gSob/cHB9jZDjBUpkJCtUIKuNgPQVdTBQCoSOs2FL6Idx/UgUDWinlVszmNaJm4rBb3EQe/ILE94E6h3YAr1veSFi9bDt7iRy+NphtNqxifDDcA0T3oXnlu8Nw5WtxwRz4lb4byTfqcgUbE7JhgwkcUORcpMuKqnkoo6ePKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSD+X4DUxyTvL7UCzhrD0W/S3kWEV+K6dIqdf9Mrxjw=;
 b=nXP1xduiqLIhhAUhtKVfd7dpz+wwxr8cLMwwQzNPupxWtsyhN4yVCuG2pvoUzipLp3TVXPtn/Hx3tDcbktOpqKVwzrHFMBBMpJvCuWRJmUo/hMTqebVmq5AoCp/5HNbC7A3CFuP5ojDuOPBsMPPhEA3QNXERgSQI4f+q3VbV93GUt4mI0f3DeHLqbKgw+U3+/FikgL1+CfdwpvSevkzOGra6V+XNhB3+8+arPZDEMZnZpudEuz1SpZ5dT6ctrEm7Kuy10XPPBEQD/0iTti9IG5CdVLhZ6OBlW9djvQWiVxeBHYqCf8EXWEJKoWOZbUlLhy02G1iCKvE1IeDgZUerdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSD+X4DUxyTvL7UCzhrD0W/S3kWEV+K6dIqdf9Mrxjw=;
 b=cbnaWweqHeCYsigONP/aVnCr6R0MjDRLAx0w663SpR1+vMSPgqaf3jj7fnKpbqU0mi0M/g278OJZ4EWIH+7EpjzN4yA1z0RNFywtwix1pcgKnmNWSdyuHQyLLOwur2hDFcOEXlaUmRCoCNm+9l47I0kSTGO0sjajIwJpSbDh7B8=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.9; Wed, 5 Mar
 2025 23:25:14 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 23:25:14 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Support holes in device list reply msg
Thread-Topic: [PATCH net] net: mana: Support holes in device list reply msg
Thread-Index: AQHbjhgydyWb3L84s0+3xp8tVlFj87NlL1dA
Date: Wed, 5 Mar 2025 23:25:14 +0000
Message-ID:
 <SA6PR21MB4231E793BBD8B6034683A387CECB2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dab66614-6095-4892-ad89-4188f106b193;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-05T23:24:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: 666d1226-a751-4b5e-1437-08dd5c3cfb71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2EeacopvBvEN33sYmhVIqfVKx/htzfeBnJuLNoozf0IkZNe71D4Obo002MRm?=
 =?us-ascii?Q?u0slEP/0aPh/H0XC8K8G8NUfSwQU37Z/736vxp8LGgDt1ZGrDyJzdBjpuR01?=
 =?us-ascii?Q?xKNHBtJwJwbksQtLm5ZgCvhSRXkoXvOJcdiWkytu+WlCVZAkblqAKXgQlm2T?=
 =?us-ascii?Q?vsv0qzFTMe0IOK0z3XX39lO7sT+Iu+Ed+z7l1apl8fX5oZEVJWxEWwWNL7cP?=
 =?us-ascii?Q?kcDaQ+/hcOdE4f65MbmJRIjFcLc6e1mGm2VtzihImAsD3iAb9BEeN3NzThMH?=
 =?us-ascii?Q?6FBZ+8WpGfoyg+6LN4mEc+nI+lW5sP1qiC6ExT5WYskMv4/Ls45QkOz9/vx+?=
 =?us-ascii?Q?0Pw48gmiehVcb+qaufHo2zLW+Gstc6HyGXVUE1kvEqDFK3Z8E18t1zhbHVYA?=
 =?us-ascii?Q?eQudQxYHR4kNPNGoODjw4Mkfh7DDZT6n4/lzSVeK/e3NcwiVsy8qCYcgyQAt?=
 =?us-ascii?Q?SO6dR7ZkR9B0KQge+keBy3yA2ZVj8FAnlXj3IK2BjsYJ7hP7LRAksa6voWAN?=
 =?us-ascii?Q?9lWFljXo5NXEnjsi2QZtxCJhQDSsXzgEfzzsTfSA0nwluw9fLHq9BACWmHC/?=
 =?us-ascii?Q?kKMPcxF13xCP1MYxe3P9z0/wVxaqCnflvBqfMsseGrObxGSZD0K/GE6AZ/2G?=
 =?us-ascii?Q?S9rcgotuvnoucCUykiS1mjkc/tYHZVrI8nxDp1D0FU1W5+Ax6BfqW0TbU3zF?=
 =?us-ascii?Q?v8Qt+LPEZ9LgDRrr5hf3VBE1M7jKMXAe5d7rwKERCOC2YStGc1c7PYP6/OMP?=
 =?us-ascii?Q?KXJYRoAFSaCh9YdHzV1ngrT2H9AwsLRZUqms6NMoOOI09p0C/8qQplguFYqZ?=
 =?us-ascii?Q?Ne6jCeAWNvcUm2TtVdV2XdOywCygPVZA5z/fSKvFrRRMPSYIM11yyI1ti4+A?=
 =?us-ascii?Q?T/ZDJUpttxQGg1G3euIgzyhJj6ihADDY5Lg0zMoXGPtfCAIRHV9ObEorMlor?=
 =?us-ascii?Q?M3s+5hknoJCLi7UJCzTw+I1KeIpNjxT66RJ5CIc54r4Wd1qEN3uOHyuTqlhU?=
 =?us-ascii?Q?Gs+r+epvsCTrb2xYyuonhV0BoGQixt2I5d1SsW1PrYTKX5Kdu9mdcqaXIElj?=
 =?us-ascii?Q?vjViquF1t03i//GD9XL5J3AFm2tKgVD1MNMaLxm5cSCBSHPIYCL0WCQbVCdT?=
 =?us-ascii?Q?m8c4LWEqoG1wLEL5WyaVIDAu8HP46WS5Ee5Tr+wZ/3/GBK1N7+ni4kQhWd7a?=
 =?us-ascii?Q?MPQkZPiYhT6mvFfOO2ggDe+u3m/aVUsRU055v/v8npqYtyBYnCLmdT7KctUn?=
 =?us-ascii?Q?q2zRPguLtaGB2zWtMISgAZ8/kJ9TdHDowx4F0O/ao4h5Ed+lMgdUxVoA0r4V?=
 =?us-ascii?Q?J6TvBI2SLBsi7yXghwI2HtzMldZIC5+XO0PXGrGQuVoY1k6R6qzn+yl7Mwx8?=
 =?us-ascii?Q?thl1KE3gJmgLMiH69LjcY3A/nnFVdD7tVjzDSMqmcU1GcoHbE3Z5f78sXNE3?=
 =?us-ascii?Q?Ati3uSMbJcmfdLbOlQ2oLlKVaLwn/88W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qiahNYlUr8XADjtc1CIO7Na5m1WNrL2msr2tWrX1hQpTvNX9tzFUlhQXpMej?=
 =?us-ascii?Q?s2RJhJynaw+7ajldiUuATNoVSASI9hZ4K2Z95sq+jWvJQCwDV0J9f8aUuoY8?=
 =?us-ascii?Q?vXFd7CxTTPVXUFN9ONHEDDnUv5udOGAGX7Mgo41qob2JjNl+h6PrMgTvDew9?=
 =?us-ascii?Q?cVwPifZ2iP76hthv4dnpnRoNVqVzMNHoJ4HdB4UdDcmbw+ppFQ/iQmNnzdZY?=
 =?us-ascii?Q?u0QLh+5z6R0ltXQ4CJOtxaioYkZ65zZtuodN671EM63p+9nMwcSI9A9Ek0CA?=
 =?us-ascii?Q?+cdj9+I5epWadG515Zd7kmRRUL5EVVbnuEbQJ9R4SYVleQnRuXFEF+s8JohA?=
 =?us-ascii?Q?0iyGjuRLZDJ1RoCjZ2fik4OxpLVqsChl/Z9o+jk5ek9xRKwtvYzfWVA1gvk8?=
 =?us-ascii?Q?4ZV0dZF8K5TyIbb/+4CsFCnN1TseokvSO9akhBFKvSZ5m/H6yWZqVavk/tRj?=
 =?us-ascii?Q?rA09710+Tdm4pz74qa63ViWm9+kSRFXEaxnVvgd6QG94WsNMoOk+Fy12LW5v?=
 =?us-ascii?Q?AqSJKtvzRnDSkZ8St62grIsgQ76daJ9nK2qWrALU7HazZ6pgglkLBfV/PA/n?=
 =?us-ascii?Q?idoUs9lKYLl9t2lIT3PZtx4RxoDdnHhC3H7nfSRgOpqc6Ausb/9wAIU5D4Vn?=
 =?us-ascii?Q?dEhGnGitKchvPNI9UPLlSBBRDVLIvQozEpL+laFlv5LWPjMk6XyxhlgXGXPO?=
 =?us-ascii?Q?qBZvonXbjqhl6yU89IdClxR8HKfgkAAbSxBLa86EAP9iavwvEEj4r6PDuwmO?=
 =?us-ascii?Q?9WWULJEFdHF10QJvawiY5gxbHghSpnbhV40hCSJKsoSlkZFdeJ8TEd4v6CHU?=
 =?us-ascii?Q?RkbOTNhZRF4cgxvHQWPuL9zkI6grnYrjrEaCQhonOZEIu4oVddz6/SM5nQcW?=
 =?us-ascii?Q?ZjOQtYhAm3KvaPEkZzYl50/lxRkXd6utRMs+oasViQ4xOyFD3MFAwTF7ko+7?=
 =?us-ascii?Q?xe6GsFPoINkqI9zh8Hn6w4B/0tedtvQ8R860nr1DNFQBprMWB780iKmKgfVL?=
 =?us-ascii?Q?lb9sxR6YxOIzN1W/nbCBgI9j652DtEZlpyQYlV0sUFYsVMnWxkkU7/r/4QBq?=
 =?us-ascii?Q?Htj40ruV6EQ7F2fFY+/6czd8vxOMxe+M4Wwsfg9RF7Q3x+m2/YdGq65sbVPq?=
 =?us-ascii?Q?euNc/6ofRfuc1kQZNAmHq1nt9LTRR+YmPTqqhHS+HhZzCXXh0pKG3y104uiT?=
 =?us-ascii?Q?Ri8GWXozjX6SQO6eo06ODwmxK5V0PzJm4u8KegEBcA2Js214JEfcOpo3vFJ+?=
 =?us-ascii?Q?iBuQwn/60Omk2YftD9mdoCe8psq8ugSeVkuGSxb7eY80MFF2m/cRj7QH5GXP?=
 =?us-ascii?Q?ZQlPBvu/wGSbevJo2uazjrvaZW9EFvxtrTQAMRQj3q8oeG2n+0EURVaYdUAX?=
 =?us-ascii?Q?pRzr7DGe/H+fXe2EFlHKJfLg5mgbwQJU2GNumjPDQfWFQ1lNPTCzRFev5e45?=
 =?us-ascii?Q?g/9ZyceoUgSwHR080N+THrxkfivtDhjsXxE81i3oYAmnKkpLjiT+KiXHl1te?=
 =?us-ascii?Q?HUhwlnqr4mCYa0TpSlN9/aTmFc5B1exqIRAf43JzOyr45ufKPFxvtIKiSlvk?=
 =?us-ascii?Q?kKTdyODnjHUbY/edUpDcqZDt/LfSdSAmx39tR0U4VpRfmfAlm1YhlJg2zSz/?=
 =?us-ascii?Q?8GPS91HTRcrpZlLwRSV/WT1eEDGwNPwPvBKZuqYn4Ed4?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666d1226-a751-4b5e-1437-08dd5c3cfb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 23:25:14.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSH9TqYooLrKLUTFz1TfA+e9ywozil4nLlWxnk73mDE+8C0m3+4X5cpzW/BgledzVdCuk+6YsnJH4h/wU3zwqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139

> Subject: [PATCH net] net: mana: Support holes in device list reply msg
>=20
> According to GDMA protocol, holes (zeros) are allowed at the beginning or=
 middle
> of the gdma_list_devices_resp message. The existing code cannot properly
> handle this, and may miss some devices in the list.
>=20
> To fix, scan the entire list until the num_of_devs are found, or until th=
e end of the
> list.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

>=20
> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 16 ++++++++++++----
>  include/net/mana/gdma.h                         | 11 +++++++----
>  2 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index c15a5ef4674e..df3ab31974b1 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -134,9 +134,10 @@ static int mana_gd_detect_devices(struct pci_dev
> *pdev)
>  	struct gdma_list_devices_resp resp =3D {};
>  	struct gdma_general_req req =3D {};
>  	struct gdma_dev_id dev;
> -	u32 i, max_num_devs;
> +	int found_dev =3D 0;
>  	u16 dev_type;
>  	int err;
> +	u32 i;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
>  			     sizeof(resp));
> @@ -148,12 +149,19 @@ static int mana_gd_detect_devices(struct pci_dev
> *pdev)
>  		return err ? err : -EPROTO;
>  	}
>=20
> -	max_num_devs =3D min_t(u32, MAX_NUM_GDMA_DEVICES,
> resp.num_of_devs);
> -
> -	for (i =3D 0; i < max_num_devs; i++) {
> +	for (i =3D 0; i < GDMA_DEV_LIST_SIZE &&
> +		found_dev < resp.num_of_devs; i++) {
>  		dev =3D resp.devs[i];
>  		dev_type =3D dev.type;
>=20
> +		/* Skip empty devices */
> +		if (dev.as_uint32 =3D=3D 0)
> +			continue;
> +
> +		found_dev++;
> +		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
> +			 dev.type, dev.instance);
> +
>  		/* HWC is already detected in mana_hwc_create_channel(). */
>  		if (dev_type =3D=3D GDMA_DEVICE_HWC)
>  			continue;
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 90f56656b572..62e9d7673862 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -408,8 +408,6 @@ struct gdma_context {
>  	struct gdma_dev		mana_ib;
>  };
>=20
> -#define MAX_NUM_GDMA_DEVICES	4
> -
>  static inline bool mana_gd_is_mana(struct gdma_dev *gd)  {
>  	return gd->dev_id.type =3D=3D GDMA_DEVICE_MANA; @@ -556,11 +554,15
> @@ enum {  #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG
> BIT(3)  #define
> GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
>=20
> +/* Driver can handle holes (zeros) in the device list */ #define
> +GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>  	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
> -	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
> +	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT |
> \
> +	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
>=20
>  #define GDMA_DRV_CAP_FLAGS2 0
>=20
> @@ -621,11 +623,12 @@ struct gdma_query_max_resources_resp {  }; /* HW
> DATA */
>=20
>  /* GDMA_LIST_DEVICES */
> +#define GDMA_DEV_LIST_SIZE 64
>  struct gdma_list_devices_resp {
>  	struct gdma_resp_hdr hdr;
>  	u32 num_of_devs;
>  	u32 reserved;
> -	struct gdma_dev_id devs[64];
> +	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
>  }; /* HW DATA */
>=20
>  /* GDMA_REGISTER_DEVICE */
> --
> 2.34.1


