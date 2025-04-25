Return-Path: <bpf+bounces-56668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D6A9BF55
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040D7923B40
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8D237170;
	Fri, 25 Apr 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gUTyxaZ6"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76D22FAFD;
	Fri, 25 Apr 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564949; cv=fail; b=DaA12CApAg1BxT/mpZHD7f+SxbJbmZePG0UkLwdnwCAa7hm0meE4HnEbmfe++6bAQkbNw9PdF8fceniiBjQ9DOYB756wr3d601oE/XZ3AJeq0i2AzLFaqvtU4plYMBJOWy+vCgY0OE2YYDVW7qOR19UFJwC+FB6703IZY5sjryE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564949; c=relaxed/simple;
	bh=zMASIzDR3bAtK1cJdpE6oGUuBjRpEKevX5rtqDSk/jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0QrJYykNk04qV8qSKgjGnpxkY16mN4MzMJm+P5N9Ex4bu6VCaAGCDuoMz+b40v0ut7BIJSAfkxuSSV96mxE4JZS/9WeUJTUVcaBkKoKBBclvYm8jQUFtGB7KpjGISJjrGBflHrqXZnPBeuRZVHxwzfKa1830Le+2JukHJ0yUIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gUTyxaZ6; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty20c2/5CuzZW6pK24L1j1H+HBvpW9ARQlDFExUclo/Z3jaAmJrZO419VlYOlXZJxn+9MwNcS63HwukwIGz+/oymL+0S5D0Dc9zTGc+z1ZMLuRjJJnfO8cB877oMPSy7k1O2f3OYvrJg0lyUTLb360OWz4RGcYalc5oNTM6nf1hFEdpVkgChtlvY2jCvNRuDjgI8fFziUuB+KHUf5YqndCvCB1q4U1xZC4vkuu2F4v5RYehq/HpWazP28y+gCCYRfYsXBMMFpif6Vltmoz1mcKC8hTxrnKAUJxjVdK4nM6mokBycBp9sKnoqg3wKQiQ57IGJTr6BZxZy/wKfJ4/tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMASIzDR3bAtK1cJdpE6oGUuBjRpEKevX5rtqDSk/jM=;
 b=jayUmusthWG1Lv9gll/qORxGi4k+QtfP48fVLQoGdRqay0gZhZVhdMLiXiyZY6480xu4RhVrZC9mwtusz+cgaFNpdSbD3GqPMxgiKBVVlFfFHm7yE3S/xxV8IQJgy4mCJAaasa5HFqnPNAk8cB0J5O7k4o1X0+IT8ath8OOR31bLXbQGlP4MUY+4gIYKHlpBY+K9XYvJCaAKXWuuGxTgAaxkBz+4WVrBwZWrouMPvGJBcPgUxkTnUXV176aduahwFzG6WopZr+qunnVEkBJMMtanfO/ZpyM4Q1UfAuNSWG9oX6Sf91AXkDul05IIiWKZFbQ2B2/CymB5pVa+MtnDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMASIzDR3bAtK1cJdpE6oGUuBjRpEKevX5rtqDSk/jM=;
 b=gUTyxaZ6cG1eUMQGQf+5lwWNlYhQMvT74rxQesdYwUX1/t+1R4u5GF2HWg4L0ajq1BvftydnZeoFhyOOhZ+z2MxGP+Sa3Ew/oofaHjRYJEbspIQqGU7VT89tqBpA9lchc8N8dpRWHkfLQ9zr/wMYqro0s4e6t7XemZe2ADasBq+VDJ4nbra9vfCgFRg20/pRmGQLv7XK9QrbZNg5XTRppwFv4wYneKfxtMEmR2bfJagDrfT15bxoNYwIPeiwlrTUYhkKoycNXUSmVoz/ovZwzFhz0c3Ph9eo7yLPLJks/u4kxBgHonUjkkpH+Wu5MhPGnDFNwnDF/Dpz5ZrEiTY0ow==
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by BN9PR03MB6011.namprd03.prod.outlook.com (2603:10b6:408:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:09:06 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 07:09:06 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>, "Gerlach, Matthew"
	<matthew.gerlach@altera.com>, "Ang, Tien Sung" <tien.sung.ang@altera.com>,
	"Tham, Mun Yew" <mun.yew.tham@altera.com>, "G Thomas, Rohan"
	<rohan.g.thomas@altera.com>
Subject: RE: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Topic: [PATCH net-next v4 2/2] net: stmmac: dwxgmac2: Add support for
 HW-accelerated VLAN stripping
Thread-Index: AQHbstql1M+19hkYQkerBvuZ57i4x7OyuVOAgAFCtdA=
Date: Fri, 25 Apr 2025 07:09:06 +0000
Message-ID:
 <BN8PR03MB5073E770EB46B2BBB65702B7B4842@BN8PR03MB5073.namprd03.prod.outlook.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-3-boon.khai.ng@altera.com>
 <edfa1585-c10c-4211-a985-ebfcb8e671d5@redhat.com>
In-Reply-To: <edfa1585-c10c-4211-a985-ebfcb8e671d5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5073:EE_|BN9PR03MB6011:EE_
x-ms-office365-filtering-correlation-id: 64509013-ff05-43e6-881c-08dd83c81121
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTlkTFZ5V1pmWGgxN2hjcFBXWkVvcXQ0cGx5Q1JMM3dscEExU3JwY2lrbElR?=
 =?utf-8?B?TktQYUEvWUFXU0toVUlVS1VXR1RwdnZWdG1iMng1T2hrVWpGRkNxM2JVaGZj?=
 =?utf-8?B?b3YvcGxGSmdMUS96NUtxaGZKM1RFOUtRNGIzNnROYkFuWG5jRndEZ1I1aDBm?=
 =?utf-8?B?dTh2TnN5bXNZVWZNK2dzZmlpM0lrSnJoN0ZwUmFWZjh6SUEzeEw0aHVwNTY2?=
 =?utf-8?B?TCtkMWRGaG8zVUVnNmJ2aVVOVEtxd1hWR3B0MlZJUENlWitJMk43dm1WRTJr?=
 =?utf-8?B?Q0dUWm0vUDZjU0ZXQjVEUjE1YXR2ZGtZOFlycWljOVo4NGswUGxzaXBPWENX?=
 =?utf-8?B?U254NmZQMjI5Zm05ZTNWMkVqMkFXalRCMFZUUENTakl3MnFXSGhzMTM3ZWt3?=
 =?utf-8?B?d2lrZFNrcHI1ZmlsRWNjb3RFa0tQL29pSVIzYmdyL2RDOEdFelhSMGxMNTNr?=
 =?utf-8?B?WFdDNHkrMkhCQksvZG5rNHdXNkN3QzRybGNWcU9Kdjd3eWcrUHVWMWZoUXp4?=
 =?utf-8?B?Q29xWmJibjhGSXFZdnFDZi94ZkJ3anczNjRKdVl6dCtRK3VGYUloeEsxUnkv?=
 =?utf-8?B?dDBvYURTek1YcjE1ZUJ3NnlacXJlR3dyd3BIN0dWbnJPQ3MrSXc5QWIxdVk5?=
 =?utf-8?B?bnV1NzlzTEFDZjhDL0FPcEFRakEvN0taN2N6ZEFpL3FxVmg0R21mUUJZOGg3?=
 =?utf-8?B?M0srNzMvUitYU0g3SFNPQXRXYXlldXo3MFVJdUFpaVRnUkFMVW9UTE1UL21w?=
 =?utf-8?B?cWxCTVVVNUNHOGRQbkdNN0d5ZFVWaldDQXFFcWFoVDBxbnJ0eXZ1QWl2K3pa?=
 =?utf-8?B?MUVGRnhmS3ZzMWVlc2l3NzBlbGZWdHdEZXFobENqbmVuTFBZVkpLZzNvaHRH?=
 =?utf-8?B?eGVDdUUzTnFxMXBqQXRBUklqSkk0cVBUV3BUY1BZdStCcUNSeGRiSXpLNmkz?=
 =?utf-8?B?SkxXQzI3OFlIZ1VQdnlLbTBTRjFPajAyMWM1d0pMekhFRFhncE1MMzZiQXVZ?=
 =?utf-8?B?MklZZ0VkOUpmMjZaZ0RuZVZ2cDVDR3Fwdll4WVFWZDRpeG9TSVRBVDN1U3RT?=
 =?utf-8?B?VVJUZFIrYUF4QUFiU2JONURjYkliZjRPWWlicXdRMC9DaXptY1g3WDI3aXli?=
 =?utf-8?B?SWtpbFQ1eFhKcWwrY2Z1WXBacGJVbXJJYUNxVE1IOEFadVl0dE1odXlLZ0kv?=
 =?utf-8?B?Z2hEK2FuZ2w5WDRqbDlNdlRMM1hiWUhFODBLZ0gxOW16NWlwblc2QjJxcWYw?=
 =?utf-8?B?M3k5d0krMU5yZnp1WG02VU1nMWJGR0pmVmREekpnWlZYVjcvVUorL0xoUDZx?=
 =?utf-8?B?bi9zWlNHcUhlRGxGZDNrdkNmakFTVFFQTmxBemVjRm1MSEdmc2xPSVB6ZWVI?=
 =?utf-8?B?ODlRQ3p4YnZNeFZTdUcvNnY5dFNhcHVvZzBXaWd6VVBWamFpMkVXYXBqRUwy?=
 =?utf-8?B?ZkdXT09IVVJxVFZRTTh4VU5RejZpelFxV2JBRjE5MEFCb09TN3JXQjZyQWhP?=
 =?utf-8?B?Rmx6bXZFak9tUzNHQkhEd1ViQUZIbGsraFoyeDRHV1hIR084VjFVd292QUZZ?=
 =?utf-8?B?VVMzb0lVc0tSL0kzQWFiMlFyQjVaUEV0VFJOcXBka08zSUkxNS9YVFJiNklY?=
 =?utf-8?B?QjBCdWJ6MWZiK0lxWWZvbHpaU1BCQ2tpMnJTb3NXU1A3RzE4YlFRT1phVk13?=
 =?utf-8?B?aGZOb3kyRTAzSDErVVFvMGk2SUtYWm1UTzh2aHd5UWJ6RThmUzdaa3ZDMnBN?=
 =?utf-8?B?Q2p0OXV3YWVlSEx0cFpNUG5zZmc2VkZHejhyYTFqbmkzbXRNMWVSZEZtODYw?=
 =?utf-8?B?a084S0k0dERoNzJDeW85R3R6WnV3cTJ3bzZzQ2FZaGdJeGZTbGFTSmxoaU9N?=
 =?utf-8?B?S3dscHdVN3dKdER4QjVlT0dtVnZHbXJtN3RicVJwRCsvQ2xSUWduMlhHdFBl?=
 =?utf-8?B?MTdOMXRETFk2aHkveTBUNGVRb0Z3NzFqWks5NFVuZXM4THRQbzNvbFpIN3Fv?=
 =?utf-8?B?NWFuS05mQ1N3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk5kWHJ2NHhDR3RyclQ3Z01WeHlnRVI3bWZtTzltU1Z2Y0U0cWV5N3RqV3ha?=
 =?utf-8?B?TE5VRzZGbG5IRW1WTWdON29Kd1BNSDNjOWpZbzdrWll5bDU1a3Fxd1VXNzJH?=
 =?utf-8?B?MlAxbkVBU3p2RWFtZzRzSHRZMTVQcndGWS9nWWZzeHhGZkV5QWxWaGNQWE5v?=
 =?utf-8?B?UWFmN1hxUjl3cVhmUFJWclRRVHp1TVRuTnZGeHdnWFBTNzFnNXgzM2NJR24v?=
 =?utf-8?B?Yng3NTczUW9hTlMyaG5QM3RKSDNTWHc4M3VLWkdpRUIwTTU5ekFmSzdOV0Q4?=
 =?utf-8?B?enhqMzVMaTArZkYrYnVpZC9hY2JJVzZrS0JGL285QkZUOU1uWUFnN2ZSMzIw?=
 =?utf-8?B?SkZwU2ZxTVJLbzhOeU13dU41QjBCeEZPYjM3RnRpa0lveVA0T3MxYmhwTUw2?=
 =?utf-8?B?d2ZmcFRyb3czZDBsYm81VG5OdlR6ZU9tWXhQM0lqT3d5dHM1MVNCNTRTbjVT?=
 =?utf-8?B?d2d3aFlETjJ6dVFDQkRsWThKOGcxVlhkTytrOHpqTG9FR2VwWFdLejk1TTZi?=
 =?utf-8?B?b1dTY1JqVkZMdWsvSEIvZlFtRCtSTmVOZFh1MXo3RlZwRm1RTUNmblhFbFgy?=
 =?utf-8?B?NEw3MC9MNC9EeXRUbmRTMFhPNEFlend4M1BYV3FBdU9HNkZpaEpaVjJTUFBU?=
 =?utf-8?B?YUNtWHpNb1F5K3J3RXJHd3JTbkE4Y0JKczV3dHN2SHdCemV3ZlY3eWpCSVJ3?=
 =?utf-8?B?VmRzQVBycENnc0htZ0NhQWV5eEdzU2F6K3hMTGZRSG0zNVltVFdxWHE1b1lO?=
 =?utf-8?B?cmR5aHJoc1RyVVVsL21FVkRxbi8wdnBzZ25DSEVEMlN1eURQWGdYckRqbmNX?=
 =?utf-8?B?SUlvSks0aTZZUHdIeHJGa1JqTUxpSTIzN0craExTMTBPRVhaZzNvd1JaTVBI?=
 =?utf-8?B?UU1CeFMxYXdWQmlibXdoWGRnQmU4VmJhUjRJVDFDV3lhVXF1TDJQU1dwbVQr?=
 =?utf-8?B?QlUrRmdEbndrOGxmbFE2NGJ2Rk5pREw2MzN2aFd4QjYzWG5lZytDOHVPcWww?=
 =?utf-8?B?MGVNbWxYanhXeGhwQk0vYy9Ya2w0eThqS1VaL2ZMR1NwMW95d2JhT0NDS0t2?=
 =?utf-8?B?cXFQeFhadDNBQ1VGd1Jsc0U0QVQwdDlzQ1hGZndUY1VzU2JvQndDYi9GYnZT?=
 =?utf-8?B?aWRPTFpKWGZaSTZZMDVEL0svVUc0K3FRaEY0eVFJQkMzWFdadlIzUTFEU3hh?=
 =?utf-8?B?UjkxcDhTRmxia3hIcTVjdVZOSkJkSE5BT1RWUFBrVmUya05VbllPejE2UktW?=
 =?utf-8?B?YVA0dUVwUVZpc0p1YVp4eFVWYkhOZnYwR1hXUUlnMDJTYWFCcnlZbXZ0R2N2?=
 =?utf-8?B?d0k1TEcwRE5aelN0elQ2R2N1dEptK1hVSzE4SmViNUVLcElIUjEvd2w2NmhW?=
 =?utf-8?B?Vk9Qd2pWVFdnQ00xV2V6WHlHc0dld1VWNEJqaklJMngxV0k3Z29LVGpEdVln?=
 =?utf-8?B?bC9vcjV3Y0x3aXBVR0JqSmphTnVkSTBtTzQ0NGxkbUVpclZyTzlKTEpQbWV4?=
 =?utf-8?B?YkdHdUMvZndzUG5iOGdCQWc0SEFNWEw3OWpUN092WjN5Y012dU44V1owYkow?=
 =?utf-8?B?aDZCTUszS1JqVVppNHZHeTAyUXRySmVxRG9MQ0lta3FCZWMzRjliNG9zV3JC?=
 =?utf-8?B?WkVZRkx1dnZrQmFXWUgvNmRFUU82K1YySkZPcHBGYURMdXdaMkhKTEdXZ3ZG?=
 =?utf-8?B?SjhUSEdmenpVT0o1S0xDL2wyM2ZUSFBXZ25pd3dBZUUvbzVXMGljb2RHOExU?=
 =?utf-8?B?eklpTDM0NmFkNksybjBBcVVUdDRERzNxbUozeFBHUkJVZGdOUXRLeE9qWXc4?=
 =?utf-8?B?NWZITzNicGIvL3lEQ21oUDJUclU2SHNOSmdoSlpxQ0JaWmZBMlgzbkY0V096?=
 =?utf-8?B?VnRsOHU3SGxZaEh4ck00QXl1V3NlemxxQlRtd2hneFhHUDEyL2VIMGJkc1Ru?=
 =?utf-8?B?NWVHMHc0cEJ1a2ZHUDRPVHdtUlpXOWVpUXNETGxGc3VoU2pxeUQ0YURVcUds?=
 =?utf-8?B?OHZiVVkvWXJjKzdOaS9YTDBORWEzSU55UHVXd1hEaHRTVWdkSVI1Yk05RjA3?=
 =?utf-8?B?UTBaOWNTUHQ3RFJ3clpOMDZsK3ZteE9zWUY3NjhLMk9keXlqUUhQM2NHQjlU?=
 =?utf-8?B?eDlRME9xS1FzRkJraHFOTzMwTnk4Y29EUWdWRHp2bnIrNmtzQ2l2eDNhZDVT?=
 =?utf-8?Q?PyhChl2g+8NdCt1uqhTBKiNtGJ7Fp2QF97LCQUIYJYOL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64509013-ff05-43e6-881c-08dd83c81121
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 07:09:06.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKHyKSLWfl26C99t+duH7bZq8k9AQQ9QAJP8aDNQmuXoUNzSNeLYpFiWXvo1eti9wxSrMTCdwxnJwg81dSsG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6011

PiANCj4gUGxlYXNlLCBhdm9pZCAnaW5saW5lJyBmdW5jdGlvbiBpbiAuYyBmaWxlcywgZXNwZWNp
YWxseSBmb3IgZnVuY3Rpb25zIHRoYXQgd2lsbCBsYW5kDQo+IGludG8gZnVuY3Rpb24gcG9pbnRl
ciBsaWtlIHRoaXMgb25lLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUGFvbG8NCg0KSGkgUGFvbG8s
IA0KDQpTdXJlIHdpbGwgZml4IHRoaXMgaW4gdjUuDQoNClJlZ2FyZHMsDQpCb29uIEtoYWkuDQoN
Cg==

