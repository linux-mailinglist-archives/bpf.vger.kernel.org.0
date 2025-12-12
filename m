Return-Path: <bpf+bounces-76528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF5CB874C
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82006300AB03
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA43054D9;
	Fri, 12 Dec 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WA5X31z5"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D732D73B9;
	Fri, 12 Dec 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531724; cv=fail; b=MyTYkvw+br7Cf6VMjY0ei/HalbTDJW021OXE/V/azgiKxmENv81yhAKwXTlwubLInpAJgCodkc4i7YTJfQzkI+Uky4dnTMzDprH4tJe3S0Z940+L63nT/c2PMq53wFaRip1jEkL3fdoL7MvjAiSAj4Xl+TSQG4whSJMR+OtF2rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531724; c=relaxed/simple;
	bh=Fmy5J4yuKvAKjsA1nIC2X7I0b1f4M8WKO9DoooAKRUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RL9o5JPun73zRbgOvCHs5BJiLzYsyG/8YrTWXqdTa2F6vriA6X0DfKg+HUSH0F1pnzU0AQJoJzHebPV6ChawzQXm0LNWGOReL6xGYDk1aiThqh4MAzvd4DWm49js58NtqQJpB5WYHcLF2o7vCL7Y12Ry/LChofK0r5OYvjYgk/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WA5X31z5; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwAEyJolacmeAVbKKZrz7maXWxZVpEpSl+ecJb3/6IYBD7pXPVt49nXpEa51bdj55vkutXQ75ngKsSDCVLNRoAa0xwaTTezIuHc8vGu8RrqI93do0uUkQlQ8jRlCu+cIEv3ZkbHRQn7Cf6sscArSJ7xdh6qfP60CK6pyNmyGMg488Gw3lEbTOav6iISPJSnTG3YEPRp55khzVpztLR9PVyv2p7n5VzgnXeLqMPQ708c1Pyu43Mqt6Uj/8CCRk2F86s+noZfmcpSs+DMz8LpVCFu/EctHjg7qCJN6lpoIF8NJHw6grarD52g7j8LG+8r5/duEw1wkRhUQD/es1oERoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmy5J4yuKvAKjsA1nIC2X7I0b1f4M8WKO9DoooAKRUU=;
 b=CpdwgxpvBm0JE44d82/7s2uxfkIP0y8876mLlDcDjG1Owxq2eA4LALLBzdNTZnCltcJY2VyOSC7U4aKKv8CseGBdylMOmKA2rRYw1+72dPIZUBx1VeZbz8OXYT7iVXLm4Jic5IrKTVUKaAnirubPlryCxd7PrWQp55IypcBR5J8dstCedRgb9Mhg+vmboIzlWSkDBVJBITR2JgncXM6IMcp0EsMfRVmJ97cloPi9GmLqrl+Wn9BBWnQP3ftYLmodZ+YoJD+MqdDFAbjr2ph+tzSJ0Bys//mjdzmBaUMMmr4kviePmruo4z2soFrXeBIRzTg1THQh/QcQbS5K41wSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fmy5J4yuKvAKjsA1nIC2X7I0b1f4M8WKO9DoooAKRUU=;
 b=WA5X31z5VfyGYkL/qYJBr+5r9qzV/UXXt8PfCRDOWYbaot5hwQYHBt66O+VhXq1EaWWVwR/BLWSRq0upYooaqJGM8shcScWHsFhciyOu2Tg+fJMGg6/KlbT0JwfU7L+XkFC+X6GD+eZ+IIuC759FPbCupf7V1ozIlGNnXr4Cbm0hEiq+v+w9hHpmaekLxlJEJGbl7B0qjtxgA/LsU0TE3iz5yc1NtKq/sKcteR2TbABTHAFcUe/yb5FWKRkobJeUSd8+nVwSJaAHHI7LcsZDBy+xscCOHwCfiXib0UQhFbQrn8jRrl1P/si3mtkT9DTJGzxoLCKJysRDjgal0NiqtA==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 09:28:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 09:28:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Topic: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Index:
 AQHcaWEJWse2oN3QYE+DLsuXp8aBkrUc31XkgAAF7oCAAD/igIAACeaAgAAxDkyAAEUiAIAAG2Y3
Date: Fri, 12 Dec 2025 09:28:37 +0000
Message-ID: <7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
 <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
 <C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
 <83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
In-Reply-To: <83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|SJ1PR12MB6289:EE_
x-ms-office365-filtering-correlation-id: 6f83c595-8ff9-412e-bde6-08de3960d46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0Q5dUo5eWFEa0lud1Mvdi83UjZRSGZjLyt5dlBiYTVUSzRlRUMyQ0xxaXNq?=
 =?utf-8?B?Y2ZFUGZvSnRBWWp2ZDdjR2Jleld2REZyNlc0bGxCempuS1Bxc0xlN09jRGlU?=
 =?utf-8?B?dkNQbFNPaHJUeGJ3N0ozUVlmeEJxMkh1c2FxU3h5SW9hWXo1S3RFZmR5cnpZ?=
 =?utf-8?B?Z2F5YmNmN3BNbi8yMXlFaVBFS3dRUjhDTGNUdUhWaHJVMmRBektSMzRyeXdI?=
 =?utf-8?B?cyswYStoNmIxQU0zK2VTQlAxWjhRUW1BTFJ0Zk9TeUlIYVZ0UFVvazdnYTZZ?=
 =?utf-8?B?VWxFR0FkaURtaWdCNjUxcEc5cUE2RlRvVllSaHgrcVBjUWVsQkgxdWFybWpW?=
 =?utf-8?B?YWVzRUNLTWwxOGtjakdxWkFGSm82eE42RFNsVGNjejQ5ZkdaSXBocnJ4MFhJ?=
 =?utf-8?B?S016L3ZUbGpmV1NscDFNUy9WendSc1Zwem1sazhXQWlxUHAzRGpwZkJKMExv?=
 =?utf-8?B?VDlyWkdxWm5yUU9iRC95UU1ySGJ0cHN1WWQ2dHBpSFkrVE1iVHpFN1JvN21n?=
 =?utf-8?B?cG1pTHZqK2xUN2VkUVQrYy9QQnd6V3VaK0lZdnZQQW96Sy9GSXJ2UGpSZmlD?=
 =?utf-8?B?d0lmaUpmTEJGRHk4RVNKQ2J4UmhnS3dWYWZQdHZBUGlNSVdZSXZTemVaY1dD?=
 =?utf-8?B?ZzV5K3pvNWxSUEZYTS82QVFUN2tQZEFXdlZwRHVTZndST3dRUGMwVWt6aldH?=
 =?utf-8?B?K3UydHRlV0w0QTgycmVsOGlSaWVYQjFWb1BBSy9oT0dxWVNuRkV3OTVKS1Ex?=
 =?utf-8?B?NFo5dFVESlNrMDVYWXliM2xpN2VSdEFXOXBKcTZ0dFhOTVZudUY5U2RyYS9P?=
 =?utf-8?B?ZEJWQ2pPa3hUa3ZHQzZHbTlqMlpCdE9INWZUaU9EYmJVOHVkQUlzOTNBZkhr?=
 =?utf-8?B?bzJWVlRWbGtYUjZVV0srZG9wZEZkaURGWTVqNzB5ZUpJNVgwRDVZdGZTTThF?=
 =?utf-8?B?SXM3dkpySjY4WURrWnlBRmg4NmxxNGxnT1diSDFidTZma2FWU2VWUXEwVmNN?=
 =?utf-8?B?SDd2UXpHMGplMTdsUlRudElkamg0ZzBXQ2lDSms2emRiYWFJS2trYnFlTy9U?=
 =?utf-8?B?WEFMMCs5WDBlOXgySHE0Vi9uR0RpakZJeE5VRTMrSXFsK0VvbG1oK28wcG56?=
 =?utf-8?B?Rm5nMnFaQXJDa3JReXg4TjZyOEtRYW04SHRVUXFKRkhaZ0E2VFlnZ1c2dlVi?=
 =?utf-8?B?dy9FblFzaU94a1FYT3JDYzZzcldOL3hJeUpyZUlxZlU1N0ZIRXJqaDFoQ3Jp?=
 =?utf-8?B?aVJQMmQrTkJGTzVodmt4bHRiOS9WYzZqTlBUSlBMdnVCRjZCclViVUVkL3Q2?=
 =?utf-8?B?eGQvRTlqWmdsOW1NeW9mVjBiMWNPNnpocWZkUDlURFFzaVF6UmRrMUgyQTQ5?=
 =?utf-8?B?R0ZrM1NVR3BoQit3TDNHRTR6UjVJbVNXeW13QnpGc0xwZFhFak1wMm05TnhH?=
 =?utf-8?B?eVBjbTZmNHFnVDlQeFBmMW1zYWU2Y3BTbkMrVTU4VEJMQXlmVVhNNGl4SG12?=
 =?utf-8?B?S3NXTm90QVVmV2NzZmZNTGh1WHE2eEM4VVhOVnR4akcyRmNjK1AyZ3NCbnJL?=
 =?utf-8?B?SmJ2TDl1dEYxS2ZIQ0xkYVZEbHMrVGRsMEJLajloQzZQV2tKdzZhSlo2ZnNJ?=
 =?utf-8?B?L2VveGdmd1JzTGZxcEJxa21MVTcwZy9lMDIxRlEvQllUV2F2ZTdSejRLNm56?=
 =?utf-8?B?emUrY29RNDFVKzdldUhqQms3TlNjN3RTNTNNZXRma1VYMHhOT1BKRUlhVTA1?=
 =?utf-8?B?OVY3SlBrajFJc05jSk5WREtSLzFGV2NNSFAxRWNEU1ZMbzlRL201aXFxcnVP?=
 =?utf-8?B?V0N6Zi9KYy9jbkpwWWUxdTgzMEljNGwyT3ZPTytLcWR3ZzE4d3U1UGxRcmxV?=
 =?utf-8?B?eVVsSUN2V2RkOEkvRGdIWTQ0RHB2aDlhL1lSZWlvRi9WZm83ZnBDVk1OY3dY?=
 =?utf-8?B?aC9xR2VpVWlvVjMvaHljZklRWjlqdnNlZlRqNEtxVkdaS2laM24rWGxpY2J4?=
 =?utf-8?B?NDB5dUZSd2pNN3FzK0wyT2RrWEY0TTl1UkUxOHNHNFBTWEl2c1J3U0dqTlZu?=
 =?utf-8?Q?Xz8zaw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVdjZlFlUkdTSWFGNWxTNXBkL2h5bC95b0M1MDZZWGNHM2VQWGJlaFo3Sjhk?=
 =?utf-8?B?SHZEeUFIR0hqdi9UK3Q0WmZNa0MwM3dWQzYybTArSnRuUTFTRlVvQ3VlSXJu?=
 =?utf-8?B?RkFoM0tMTmtldThGYk0vZFVxbVZwamlxM2dnSkw3UUlEMDZoMi80R1RwSEtP?=
 =?utf-8?B?L2FYQzIrTmc5SnIzNFhuTEJiZkVPdVdLUVFHRGYzRXM4MTFFcmhHdGsyRGlG?=
 =?utf-8?B?bUlYTXRkaDRYUVpRNkVvL2Z5bWpLeTc0Z09VZnNKOUYzVHpEUUhYdXE1bXdV?=
 =?utf-8?B?bUVJR1pPeEJOSmE2RnFLUkxpbGt2bEp2ZlhtVmF0a0g1enJOOENrcTVVbkR4?=
 =?utf-8?B?MU9xazJRRTZGdS9vbmhreG5yb0d4cmlwQnMySDJXQUhKbzRUZUdWYjZBRzFJ?=
 =?utf-8?B?eU5SZUNTVmV6anc3MmppVHVJaGh2Qzh5dnM2Z1ladnRBbHRjY251QTB3Zy9C?=
 =?utf-8?B?SHNoNGMwM3pDWHV0alFvckxoVWphMHAvcFZxaHRybDJJbkcyVjhzSzFhQVYr?=
 =?utf-8?B?bGx1aUJaT05OTFkra0o3WTRKcExMRDREYXdueUdrZk9oY0dLNXA4WTFrdHoz?=
 =?utf-8?B?NytaS1NHVDZwTk1QTWx6dURmZ2czcllaNStCWXJDUWVFd1hZTDVhb2ZGSWlW?=
 =?utf-8?B?YUpyRDg2SnRXOUtMZTl3VzJ2ZzR5WjhuM3hHelZtZzk1V2tJTnJhRDVLdFdq?=
 =?utf-8?B?dTJzTUI5ZTNHRFFvNVA0ajhXVytlTGJNWlhmd2xsNEZQODhza0FmY1pqUVMr?=
 =?utf-8?B?WFhFOGxiRmxGbldEYlN5SWJlYnpFWHJMeE91Zk5EU1NQOVpmRlpkbW9LRmJE?=
 =?utf-8?B?RGhTR2hoem5sYWwrdjZNdkZ2Uk4xM3dyVHhRZFRlQXNjNFRUSURqZjUrdVo2?=
 =?utf-8?B?bHVwUmhZQWJPRTNXSG1VY2lWQWFmOUhwSFRXVTIyZnBFbTZTL0UvVDZyb0Zz?=
 =?utf-8?B?azgwTmxxL3JuQ3l5VGM5UFFDUFRaYkJ6cytJVGJuNU5ZWjVnQ3VTVEFpSUNh?=
 =?utf-8?B?VFIyWkZtOFJwWlZrVk4zdDZ0U3VvQy91NGFQWVUySk5mYm5mVVRtazdPck9i?=
 =?utf-8?B?MnZYU3ZFYlM1Z3lNcTJSbUhJWjIwVld3Nm1YMHQ5UTV3ellOSUpVMkYwQWxF?=
 =?utf-8?B?cTA5bExnOVcrYnZVVnV4eGpsNnhGckM5TzJTeVhGbncvY1dwV2h3SDRBemM4?=
 =?utf-8?B?MENTZUhpbkNjRjFmdGVhSWZtSTVkMXFsMHQzQ1ZDc2RFYTBNVDJrNkFnNUlC?=
 =?utf-8?B?Z2ovVDlZM2pKRmM0bkR0N0F6a2grU29WYTBVcjR3NWFEZ1hLM0x4V3lvOVN2?=
 =?utf-8?B?cldIU1JaTTJqN3ljeS9MVEZrWHpsUmIvYTR0V2V2S2MxV0RNcWl0K2xjZ1Na?=
 =?utf-8?B?blRuUTBIMUVJMnVaMUJkZGdCRG1GMzlKam83UUV6V1RueFdGWDlyNWJlNHFX?=
 =?utf-8?B?TDlqM2RKU29nNkRKLytHamFCRXNzMmxJUFB3dVl3azQ5VmdEd1RrRXVGU1Vw?=
 =?utf-8?B?Tm83czBKMSt4WTAvWG5XcENrRjY4eFBlNVlUY3Y4c2NBY0h6MG05cDRXZW5m?=
 =?utf-8?B?WWlLNS85YmV6VXprelVFS2E3QlJZQkRwZStLRU5vNi96dGNnRU1zMGQzL2Jv?=
 =?utf-8?B?L25uelFrQnEvTWNKZER5ZDhoSy9lWHplT0RjNURkTWZwS3NTRVlpMXp5TFpL?=
 =?utf-8?B?SHc5QTJ2OGtGc2Y2cWo5Zmwydk16Zy81SXhxNTZMeFVuM2RzZnhwYlBDdHpP?=
 =?utf-8?B?aDRFM1lKclBiRURoTUQ1RnBiWnJ1bWxKSWhwNzFOaE5kaGtBREkwUWxWWjFJ?=
 =?utf-8?B?d0JjTUxVR0N2TkFLNDN3MEJuaE5kY1kyUGt5ZncxekNxREJuTW1ieUVOQjRK?=
 =?utf-8?B?cjNnSVlhSlFacHY3U0ZGeERyL0VYbkNpU3BQS2FtY2F0cmxkdmFpdzA2eWZz?=
 =?utf-8?B?M09kNXI0TWFieUl4cGJ4OUxHV2c2WnNSTkNCa3djazMwcDV0YlN1cHlWT3cw?=
 =?utf-8?B?RXovUk9XeVRSbHRmbmw4OGdkM1hzTXhQY1FQWGwvRXZ5Nmtnd1BwZkROekpw?=
 =?utf-8?B?RWlxSDFxR2g5MGNTeHVSS2Z5K1N2OGYrb2gzL3lWKzhMODhMYVJaVFI0aUpM?=
 =?utf-8?Q?AGZ512GZ5thw+X4YmmYmcrCaC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f83c595-8ff9-412e-bde6-08de3960d46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 09:28:37.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxnA+R6OJomKwoCXL73azepZQFbY1bxwyLUzw869/JVOfPZ5jxcvENQS8l8hBshPt0vQGHcMT3iK7J+lW641XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

DQoNCj4gT24gRGVjIDEyLCAyMDI1LCBhdCA0OjUw4oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBGcmksIERlYyAxMiwgMjAyNSBh
dCAwMzo0MzowN0FNICswMDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4+
IE9uIERlYyAxMiwgMjAyNSwgYXQgOTo0N+KAr0FNLCBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNr
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v09uIEZyaSwgRGVjIDEyLCAyMDI1IGF0
IDA5OjEyOjA3QU0gKzA5MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+
Pj4+PiBPbiAxMi8xMS8yMDI1IDM6MjMgUE0sIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+Pj4+
PiBPbiBUaHUsIERlYyAxMSwgMjAyNSBhdCAwODowMjoxNVBNICswMDAwLCBKb2VsIEZlcm5hbmRl
cyB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+Pj4gT24gRGVjIDgsIDIwMjUsIGF0IDE6
MjDigK9QTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPiB3cm90ZToNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IO+7v1RoZSBjdXJyZW50IHVzZSBvZiBndWFyZChwcmVlbXB0X25vdHJh
Y2UpKCkgd2l0aGluIF9fREVDTEFSRV9UUkFDRSgpDQo+Pj4+Pj4+IHRvIHByb3RlY3QgaW52b2Nh
dGlvbiBvZiBfX0RPX1RSQUNFX0NBTEwoKSBtZWFucyB0aGF0IEJQRiBwcm9ncmFtcw0KPj4+Pj4+
PiBhdHRhY2hlZCB0byB0cmFjZXBvaW50cyBhcmUgbm9uLXByZWVtcHRpYmxlLiAgVGhpcyBpcyB1
bmhlbHBmdWwgaW4NCj4+Pj4+Pj4gcmVhbC10aW1lIHN5c3RlbXMsIHdob3NlIHVzZXJzIGFwcGFy
ZW50bHkgd2lzaCB0byB1c2UgQlBGIHdoaWxlIGFsc28NCj4+Pj4+Pj4gYWNoaWV2aW5nIGxvdyBs
YXRlbmNpZXMuICAoV2hvIGtuZXc/KQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gT25lIG9wdGlvbiB3b3Vs
ZCBiZSB0byB1c2UgcHJlZW1wdGlibGUgUkNVLCBidXQgdGhpcyBpbnRyb2R1Y2VzDQo+Pj4+Pj4+
IG1hbnkgb3Bwb3J0dW5pdGllcyBmb3IgaW5maW5pdGUgcmVjdXJzaW9uLCB3aGljaCBtYW55IGNv
bnNpZGVyIHRvDQo+Pj4+Pj4+IGJlIGNvdW50ZXJwcm9kdWN0aXZlLCBlc3BlY2lhbGx5IGdpdmVu
IHRoZSByZWxhdGl2ZWx5IHNtYWxsIHN0YWNrcw0KPj4+Pj4+PiBwcm92aWRlZCBieSB0aGUgTGlu
dXgga2VybmVsLiAgVGhlc2Ugb3Bwb3J0dW5pdGllcyBjb3VsZCBiZSBzaHV0IGRvd24NCj4+Pj4+
Pj4gYnkgc3VmZmljaWVudGx5IGVuZXJnZXRpYyBkdXBsaWNhdGlvbiBvZiBjb2RlLCBidXQgdGhp
cyBzb3J0IG9mIHRoaW5nDQo+Pj4+Pj4+IGlzIGNvbnNpZGVyZWQgaW1wb2xpdGUgaW4gc29tZSBj
aXJjbGVzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlcmVmb3JlLCB1c2UgdGhlIHNoaW55IG5ldyBT
UkNVLWZhc3QgQVBJLCB3aGljaCBwcm92aWRlcyBzb21ld2hhdCBmYXN0ZXINCj4+Pj4+Pj4gcmVh
ZGVycyB0aGFuIHRob3NlIG9mIHByZWVtcHRpYmxlIFJDVSwgYXQgbGVhc3Qgb24gUGF1bCBFLiBN
Y0tlbm5leSdzDQo+Pj4+Pj4+IGxhcHRvcCwgd2hlcmUgdGFza19zdHJ1Y3QgYWNjZXNzIGlzIG1v
cmUgZXhwZW5zaXZlIHRoYW4gYWNjZXNzIHRvIHBlci1DUFUNCj4+Pj4+Pj4gdmFyaWFibGVzLiAg
QW5kIFNSQ1UtZmFzdCBwcm92aWRlcyB3YXkgZmFzdGVyIHJlYWRlcnMgdGhhbiBkb2VzIFNSQ1Us
DQo+Pj4+Pj4+IGNvdXJ0ZXN5IG9mIGJlaW5nIGFibGUgdG8gYXZvaWQgdGhlIHJlYWQtc2lkZSB1
c2Ugb2Ygc21wX21iKCkuICBBbHNvLA0KPj4+Pj4+PiBpdCBpcyBxdWl0ZSBzdHJhaWdodGZvcndh
cmQgdG8gY3JlYXRlIHNyY3VfcmVhZF97LHVufWxvY2tfZmFzdF9ub3RyYWNlKCkNCj4+Pj4+Pj4g
ZnVuY3Rpb25zLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gV2hpbGUgaW4gdGhlIGFyZWEsIFNSQ1Ugbm93
IHN1cHBvcnRzIGVhcmx5IGJvb3QgY2FsbF9zcmN1KCkuICBUaGVyZWZvcmUsDQo+Pj4+Pj4+IHJl
bW92ZSB0aGUgY2hlY2tzIHRoYXQgdXNlZCB0byBhdm9pZCBzdWNoIHVzZSBmcm9tIHJjdV9mcmVl
X29sZF9wcm9iZXMoKQ0KPj4+Pj4+PiBiZWZvcmUgdGhpcyBjb21taXQgd2FzIGFwcGxpZWQ6DQo+
Pj4+Pj4+IA0KPj4+Pj4+PiBlNTMyNDRlMmM4OTMgKCJ0cmFjZXBvaW50OiBSZW1vdmUgU1JDVSBw
cm90ZWN0aW9uIikNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSBjdXJyZW50IGNvbW1pdCBjYW4gYmUg
dGhvdWdodCBvZiBhcyBhbiBhcHByb3hpbWF0ZSByZXZlcnQgb2YgdGhhdA0KPj4+Pj4+PiBjb21t
aXQsIHdpdGggc29tZSBjb21wZW5zYXRpbmcgYWRkaXRpb25zIG9mIHByZWVtcHRpb24gZGlzYWJs
aW5nLg0KPj4+Pj4+PiBUaGlzIHByZWVtcHRpb24gZGlzYWJsaW5nIHVzZXMgZ3VhcmQocHJlZW1w
dF9ub3RyYWNlKSgpLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSG93ZXZlciwgWW9uZ2hvbmcgU29uZyBw
b2ludHMgb3V0IHRoYXQgQlBGIGFzc3VtZXMgdGhhdCBub24tc2xlZXBhYmxlDQo+Pj4+Pj4+IEJQ
RiBwcm9ncmFtcyB3aWxsIHJlbWFpbiBvbiB0aGUgc2FtZSBDUFUsIHdoaWNoIG1lYW5zIHRoYXQg
bWlncmF0aW9uDQo+Pj4+Pj4+IG11c3QgYmUgZGlzYWJsZWQgd2hlbmV2ZXIgcHJlZW1wdGlvbiBy
ZW1haW5zIGVuYWJsZWQuICBJbiBhZGRpdGlvbiwNCj4+Pj4+Pj4gbm9uLVJUIGtlcm5lbHMgaGF2
ZSBwZXJmb3JtYW5jZSBleHBlY3RhdGlvbnMgdGhhdCB3b3VsZCBiZSB2aW9sYXRlZCBieQ0KPj4+
Pj4+PiBhbGxvd2luZyB0aGUgQlBGIHByb2dyYW1zIHRvIGJlIHByZWVtcHRlZC4NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IFRoZXJlZm9yZSwgY29udGludWUgdG8gZGlzYWJsZSBwcmVlbXB0aW9uIGluIG5v
bi1SVCBrZXJuZWxzLCBhbmQgcHJvdGVjdA0KPj4+Pj4+PiB0aGUgQlBGIHByb2dyYW0gd2l0aCBi
b3RoIFNSQ1UgYW5kIG1pZ3JhdGlvbiBkaXNhYmxpbmcgZm9yIFJUIGtlcm5lbHMsDQo+Pj4+Pj4+
IGFuZCBldmVuIHRoZW4gb25seSBpZiBwcmVlbXB0aW9uIGlzIG5vdCBhbHJlYWR5IGRpc2FibGVk
Lg0KPj4+Pj4+IA0KPj4+Pj4+IEhpIFBhdWwsDQo+Pj4+Pj4gDQo+Pj4+Pj4gSXMgdGhlcmUgYSBy
ZWFzb24gdG8gbm90IG1ha2Ugbm9uLVJUIGFsc28gYmVuZWZpdCBmcm9tIFNSQ1UgZmFzdCBhbmQg
dHJhY2UgcG9pbnRzIGZvciBCUEY/IENhbiBiZSBhIGZvbGxvdyB1cCBwYXRjaCB0aG91Z2ggaWYg
bmVlZGVkLg0KPj4+Pj4gDQo+Pj4+PiBCZWNhdXNlIGluIHNvbWUgY2FzZXMgdGhlIG5vbi1SVCBi
ZW5lZml0IGlzIHN1c3BlY3RlZCB0byBiZSBuZWdhdGl2ZQ0KPj4+Pj4gZHVlIHRvIGluY3JlYXNp
bmcgdGhlIHByb2JhYmlsaXR5IG9mIHByZWVtcHRpb24gaW4gYXdrd2FyZCBwbGFjZXMuDQo+Pj4+
IA0KPj4+PiBTaW5jZSB5b3UgbWVudGlvbmVkIHN1c3BlY3RlZCwgSSBhbSBndWVzc2luZyB0aGVy
ZSBpcyBubyBjb25jcmV0ZSBkYXRhIGNvbGxlY3RlZA0KPj4+PiB0byBzdWJzdGFudGlhdGUgdGhh
dCBzcGVjaWZpY2FsbHkgZm9yIEJQRiBwcm9ncmFtcywgYnV0IGNvcnJlY3QgbWUgaWYgSSBtaXNz
ZWQNCj4+Pj4gc29tZXRoaW5nLiBBc3N1bWluZyB5b3UncmUgcmVmZXJyaW5nIHRvIGxhdGVuY3kg
dmVyc3VzIHRyYWRlb2ZmcyBpc3N1ZXMsIGR1ZSB0bw0KPj4+PiBwcmVlbXB0aW9uLCBBbmRyb2lk
IGlzIG5vdCBQUkVFTVBUX1JUIGJ1dCBpcyBleHBlY3RlZCB0byBiZSBsb3cgbGF0ZW5jeSBpbg0K
Pj4+PiBnZW5lcmFsIGFzIHdlbGwuIFNvIGlzIHRoaXMgZGVjaXNpb24gdGhlIHJpZ2h0IG9uZSBm
b3IgQW5kcm9pZCBhcyB3ZWxsLA0KPj4+PiBjb25zaWRlcmluZyB0aGF0IChJIGhlYXJkKSBpdCB1
c2VzIEJQRj8gSnVzdCBhbiBvcGVuLWVuZGVkIHF1ZXN0aW9uLg0KPj4+PiANCj4+Pj4gVGhlcmUg
aXMgYWxzbyBpc3N1ZSBvZiAyIGRpZmZlcmVudCBwYXRocyBmb3IgUFJFRU1QVF9SVCB2ZXJzdXMg
b3RoZXJ3aXNlLA0KPj4+PiBjb21wbGljYXRpbmcgdGhlIHRyYWNpbmcgc2lkZSBzbyB0aGVyZSBi
ZXR0ZXIgYmUgYSByZWFzb24gZm9yIHRoYXQgSSBndWVzcy4NCj4+PiANCj4+PiBZb3UgYXJlIGFk
dm9jYXRpbmcgYSBjaGFuZ2UgaW4gYmVoYXZpb3IgZm9yIG5vbi1SVCB3b3JrbG9hZHMuICBXaHkg
ZG8NCj4+PiB5b3UgYmVsaWV2ZSB0aGF0IHRoaXMgY2hhbmdlIHdvdWxkIGJlIE9LIGZvciB0aG9z
ZSB3b3JrbG9hZHM/DQo+PiANCj4+IFNhbWUgcmVhc29ucyBJIHByb3ZpZGVkIGluIG15IGxhc3Qg
ZW1haWwuIElmIHdlIGFyZSBzYXlpbmcgU1JDVS1mYXN0IGlzIHJlcXVpcmVkIGZvciBsb3dlciBs
YXRlbmN5LCBJIGZpbmQgaXQgc3RyYW5nZSB0aGF0IHdlIGFyZSBsZWF2aW5nIG91dCBBbmRyb2lk
IHdoaWNoIGhhcyBsb3cgbGF0ZW5jeSBhdWRpbyB1c2VjYXNlcywgZm9yIGluc3RhbmNlLg0KPiAN
Cj4gSWYgQW5kcm9pZCBwcm92aWRlcyBudW1iZXJzIHNob3dpbmcgdGhhdCBpdCBoZWxwcyB0aGVt
LCB0aGVuIGl0IGlzIGVhc3kNCj4gdG8gcHJvdmlkZSBhIEtjb25maWcgb3B0aW9uIHRoYXQgZGVm
YXVsdHMgdG8gUFJFRU1QVF9SVCwgYnV0IHRoYXQgQW5kcm9pZA0KPiBjYW4gb3ZlcnJpZGUuICBS
aWdodD8NCg0KU3VyZSwgYnV0IG15IHN1c3BpY2lvbiBpcyBBbmRyb2lkIG9yIG90aGVycyBhcmUg
bm90IGdvaW5nIHRvIGxvb2sgaW50byBldmVyeSBQUkVFTVBUX1JUIHNwZWNpZmljIG9wdGltaXph
dGlvbiAobm90IGp1c3QgdGhpcyBvbmUpIGFuZCBzZWUgaWYgaXQgYmVuZWZpdHMgdGhlaXIgaW50
ZXJhY3Rpdml0eSB1c2VjYXNlcy4gVGhleSB3aWxsIHNpbXBseSBtaXNzIG91dCBvbiBpdCB3aXRo
b3V0IGtub3dpbmcgdGhleSBhcmUuDQoNCkl0IG1pZ2h0IGJlIGEgZ29vZCBpZGVhIChmb3IgbWUp
IHRvIGV4cGxvcmUgaG93IG1hbnkgc3VjaCBvcHRpbWl6YXRpb25zIGV4aXN0IHRob3VnaCwgdGhh
dCB3ZSB0YWtlIGZvciBncmFudGVkLiBJIHdpbGwgbG9vayBpbnRvIGV4cGxvcmluZyB0aGlzIG9u
IG15IHNpZGUuIDopDQoNCnRoYW5rcywNCg0KIC0gSm9lbCANCg0KPiANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVGhhbngsIFBhdWwNCj4gDQo+PiBUaGFua3MsDQo+PiANCj4+IC0gSm9l
bA0KPj4gDQo+PiANCj4+PiANCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQ
YXVsDQo=

