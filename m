Return-Path: <bpf+bounces-61020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA2ADFAD6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E00A1BC0DC0
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB91DC9B1;
	Thu, 19 Jun 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZ6tbQki"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35151A238D;
	Thu, 19 Jun 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297197; cv=fail; b=j/9TjR8cmYFDL8ZXzbO3BMu7ZIHdI/yjY961DTGaF+mwQ3fc18gpJAVgYXSOS4EBip7Tc0d/cfLIIZZzw9b6oLgy+c4kPyM31DcRYYtBq8l0Ul3DUuCEKfM4frhwmAaL+17GClBFoXf6BsNSn+eSDyh+tOPg7P0c+N2fOBQwnbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297197; c=relaxed/simple;
	bh=KlanOofqR3k0z0EISPgC9ejeEgGucERPUVD1kNHQeHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hA0p8r62ivJwQ5sICmQjKLBL8njMN64w7805oH2mTNn8QrtxY83AT6Y5BQxseJWFI8Mm0DvnC6V1L0CUP0iZcjK+TCrIouNyqFE6TC3ee0vm71mb9G85GfUPAAR4i15rdf+rW+sc09cWNO4prZwifT+L7Yyrei/oTgCVTS6dJ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZ6tbQki; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDG4CwgfidD2zWr0x5KjWKdv85ywUt2SZ4SGWheFoVGP76DiMLA5Fuj0VVbAo97WmWFAu3yjjVdDRqaOonmExI2mrB5X0sjBYuj4eu4uJJ5DD4pB7G4ouRiGDN5aLICNfj45ptB1yb7nGKqbp8ocWj/9T3pcQ/qsyiZhe8xy6oXvUZdiZ5gSsI7HTlzIU0uQIBq5uCgfKzHA0BvBnE9v5JRkN+ToLJnimDPZvylSQJXdsSU6f8K8xT3soZByd8LFfjY290bfamSMPwBr7iI3Br9PKkitPNNt2a9/32H8tlFiooMtggvSV6z6IMeoEifFVz7Sg3J++2efmhxZQT0YiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlanOofqR3k0z0EISPgC9ejeEgGucERPUVD1kNHQeHU=;
 b=Q5MzLQAXvwjyZWTNX7cOP0ZH5h6U9RhJ2fDhf6UN8WSiWEwKoszhgD/5VjhNqJDFNfiHnudPf+OtrTjElEGlHOCoZsE0Fc+Wdjq1gd/Bs+RH8erM/Me5uUeevi6G8XBIvKcSJC75PwvQgBnroZQ7TlmiTbcA5J9VT6cjFRV7FWT98gLErekf6BcAI82QXRgrti90OK9qdmeMpYMigOpnTWp+hQ7DyJjPv7SLxVmqwk8Wl5G1wFl4wvjVYFleBRqyvhlpGDo1TwI6kQLk1eBEBhhGpfRarV+f0wyrq4a7Xu88j4Oi1ltCCLduHiZIQBdY5abYTQsD1VkStuwjd7letw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlanOofqR3k0z0EISPgC9ejeEgGucERPUVD1kNHQeHU=;
 b=AZ6tbQkimWj3NjR1x5/qUtq+Y5Ip3qBC6XcOZycBtjKwxYSLJ4sQWoJfFrnnEjFVVlfYHEjWfH/T6r7e/c0MCREDFi1pT2SHE00xD4Yvg+Tbd+KMojslWblTdrkNdI5l1KY4nyF7Wx6mIuvm8H5D6E2MubozUbaKVEMFCwn0ZpSU5cpaKNtTy5tjWwobUJYlkQ7AwMGhM2XAR/63mvrgSTKWAAe2CopJwHKVir6zLQInulJwFsI/JL/yL0s0yrJJJbphl33ZBLed3yYbeEy9fV4W+uLfJ/Lu1Ch/fKKOm6KSa6ygZSPg0GZLtAsIDEt/DV9vQSfu8bzEfTH3Nd8NPQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 01:39:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 01:39:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Shenwei
 Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Subject: RE: [PATCH net-next v4 03/11] net: fec: switch from asm/cacheflush.h
 to linux/cacheflush.h
Thread-Topic: [PATCH net-next v4 03/11] net: fec: switch from asm/cacheflush.h
 to linux/cacheflush.h
Thread-Index: AQHb4Ei89GSCi1UJx0au+4VAwd5Vo7QJtSHQ
Date: Thu, 19 Jun 2025 01:39:48 +0000
Message-ID:
 <PAXPR04MB8510E161D4AE292A961B42CF887DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
 <20250618-fec-cleanups-v4-3-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-3-c16f9a1af124@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9136:EE_
x-ms-office365-filtering-correlation-id: e1566fbc-c2b2-47d9-3670-08ddaed22d62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFpwaUlwWXN3SCsvUVF3REQ1REkwa3RBOHFMMmZ6d1FTZmpxM0dCRTIwRHk2?=
 =?utf-8?B?WTVWUll4MkttQjEvK2Z3dXBSbUp3Y3l1VnVnL3ZYY1BlVnhjbGlBSjJWaS9T?=
 =?utf-8?B?dGQ1OW9TU0xhVVg0bGtTWnJvcXNpN2lYZjgrU3JSSmtMeU5adHJMWnZ4c1lt?=
 =?utf-8?B?Uitvb3BQbHl4bFk1ZDIrMWVYekpwRGFmN1FhU1UyL3RqckhDYjVSNWZxc21t?=
 =?utf-8?B?YWRSaUtNejc0RUNtWVh0K1lsQ21tdGVuNTVyU3RrWk9vZXZLaW1sK21ib2xU?=
 =?utf-8?B?b05vdnFMdVlXNDFKa1JTZnNQZFRIcTdtbjVHWjFId0VYZlVHWWF3bHN6OEMv?=
 =?utf-8?B?a3h0YzRKd2I4Rkw4cnN0TjJVMjhSUUxWR1c1M3Jjdkx3aTB3S2hyRUZqaDVO?=
 =?utf-8?B?emdlT3FTN3NsY0trRW9iYWxMN1YrL2dza1VNUUYzQk8xbmJsQVRyQ29JNjJp?=
 =?utf-8?B?QS9TUW41ZUhobElaWi9zYWNnc05jMUNzTDJBejE3NzR0Vm84VWtWTWhCNUtr?=
 =?utf-8?B?Z3BqeEd3cTRnOG9yTDN5SnRzVUdZNE5MdFdUMEp3ek5FNVVFb21WOHBiM2Mw?=
 =?utf-8?B?dnRtKzJSTTQ1T1k4VVVzaDRZVU13YUs1czdDa2dEN1ZoUjZxWGY2UVF6U1FB?=
 =?utf-8?B?c0N4cmEwQmtVSlU4MHlnMS90aFk1UUhVNkpxOTZFemhSTVU0anJ5RWxJTG8w?=
 =?utf-8?B?SFA4VUpDRndsSGM1U3MrYm1rM3Fxako0bVVya1lldndPKzZUM2VRL0JVVVQx?=
 =?utf-8?B?Tmh4RnpoTDJKVjFvenRMdEZEL0pFN0VUQ0pPdmZNYk1wL3ZXZVVpZjFmVTJs?=
 =?utf-8?B?YjhJQVluTld5M1pydmJ3aU5Wamlkb1NwWW1sc1NTR2RRZ29ESTZUVUJsSVVh?=
 =?utf-8?B?RUhJc0RNL0tFQTF3MHVXZ1UyTTJYaTJRMWNleUdud2pQTm15ZFVkUUp6MlFE?=
 =?utf-8?B?Z1FpYlJCMTUxRzdSc2hQa0FtZ1FFNlBpYVIrSTVlOE9OelBiNG5Cclg4M25Y?=
 =?utf-8?B?clRjdDJQSzBjOFE3cWRNeHZSVk4yVUtibjFwTXVja2t6OXZHekVTZUdka0Zi?=
 =?utf-8?B?dFFlTXQzMGNiMERRa3FUd2l0YnRpT1BaMHlYaGcvMEl0SEZKdkw2OE8yOVJj?=
 =?utf-8?B?SmJBTXpvMEhNU054NFRISkpyVmZPRHRpM0w4SmVLeDA2OWJhVGxETDBaSFd5?=
 =?utf-8?B?YXJ2d1RwNk92U2hhRWYvZjg0NmZMN0tXUlVQL0ZMZWhsaENEQTdmUEp1Tkwr?=
 =?utf-8?B?a1doZE9HakhjNnRxYlp6ZkZQU1R4UTY0UGk5ZEd2VXh0NE1qUVZoZ3lrcHhj?=
 =?utf-8?B?endtelRWZklDNTlGZDV6T0sydEZhOUQxYUwzNlZjVmo1VG55Nis1bVpvMk83?=
 =?utf-8?B?Z2pOVkNXa1hBRUZNSGlUWjUzQm5DTWF4a0JqT1hkQVJoWXMwN3NhdkZRcG5W?=
 =?utf-8?B?ODBrNVJMbGk4bldxalAvVHMvcEpWTFBLMHl6OXpJaGFXenBhOUpYWk9sdUsr?=
 =?utf-8?B?T3VQUzQ3UXI0dTNtcU1ETkpnL3g4bkVCNDE4NDJ0dS95QWhDQUhja2dNb3dZ?=
 =?utf-8?B?S0VaeVpyV2dqbnFrQUJEYktXc2FDZE5SSHl5aXMzbXVmMkJMN1dudTVzQzVD?=
 =?utf-8?B?UE13T3I0Lzd6KzBrTnhDeW9OT0FHK1dYQTRsVG5aMEVzZkVqTCthRkFwNnZq?=
 =?utf-8?B?dEl3bVNpSkpJaEZodGp0VFRkNS9MQnViNEFGcFJ0MHNpWGNBcWo5aGNnSVpi?=
 =?utf-8?B?a3VNMm9PWDltTDJoWVMrc3p1NGJ5bWV0OXRFWUhjSHhlOG9VZGovMWZvaUxT?=
 =?utf-8?B?Mmk2VTBtQytwdlo4MHphMGdGc21kSXQ4ZkRhUllHc0h6YWRLRURoTGpMNGgr?=
 =?utf-8?B?b2hiSi83b1JVTGVKTXJEYW93aFkveTJCZnBucVczclJSOXpaTnBGQ3pUemFO?=
 =?utf-8?B?Q1ZoSHYvYm44bG5WRXpMTUtpRnRSMVBKYW9BMzlKaVo2ZHlhcFJPRDZLZWNv?=
 =?utf-8?Q?5huL1RuFiMeeXWscf34YrygHyU+Io4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnh2L2Y0N0dqL055Y1M3bUc3NUc2Vkt1MFQvSzRER3VZR3ZHZEcyN2w5QThi?=
 =?utf-8?B?RFFVUzA3RDhBT2YxT0JLOHVkaGNLYUJLa0dxaXdlUWVGWDlveEdnMVhhMUtp?=
 =?utf-8?B?c2kvK2loR3pSck0zRmorSXJTQXRqQWxaOENpZU80clpCYjdKYkhZYUp6S3Zt?=
 =?utf-8?B?N2dtUW5sQzdCbjM3cUd4NW9NTEVmMi9WOUd0eTV0bUVKeHZQM3FMRlRBdEY4?=
 =?utf-8?B?ZTYvOUFwSDh3TWxGSVJXQXZQRy8wcWRyUzdUVGpnbXlyc0lQYmx6dWhieVhM?=
 =?utf-8?B?ejZtSGh5WnNjbDZjYnc1aDYxMU1MWXFHVUxaRmhDbXVqd0pQOTlPWGgwcHJi?=
 =?utf-8?B?R1hHQjIyeU92OEtGeE56dWowTWtaR0tVMXhxNHVOSFJ5NEpDUTYxa3p3Q3Ru?=
 =?utf-8?B?S3BJaVJPcGJUQ1JxRk5zeUVJVkNNU2ZReE9KbjhmNGVEbm1DRUQzUzZVcTIx?=
 =?utf-8?B?OTAxcDgrUFVhOHFXcVIvTDNkK0xtdm95ZWhIUFZiVitVaXFmOFMrMXhhRmly?=
 =?utf-8?B?YXZudzFUSzhpdWhYQ2VzVUhnVDFPcHg1UFMvY2o3cnRwWkRRZXRmTmZkMnhu?=
 =?utf-8?B?SSt3MWY4bHFYV051eml5clBNNUVKbmJXVXR6eEZ5bzAvRXArOVNKZnN5VHhT?=
 =?utf-8?B?UktQNmlPNVZUYU13N1BPYXJjRmhEV3pOMHNsYi8zVDVrejdMSkxZZUN5Uk1y?=
 =?utf-8?B?U0M5Z1BLUTdzd01JTXZNUGw1ODVnWVBkSS9GTDVqL1ZCNnBnWklSby9EUTVj?=
 =?utf-8?B?cHBoWTJzQ0hJTnExeXEzNkFTNFZYYmI0akxkZG0vQmZPaDUvV09RQTEwdUJD?=
 =?utf-8?B?aHhEZXd1NCtrNlA4dG9paTdRKzJBUVFoRVBBK2s0aXFDV3NPOVRDc293L1Q2?=
 =?utf-8?B?NTlBOC9WVE9aODNOYk5KcG9nbS9BbDhmdjVpZUJTZkluVGNzR2I4VE04dGVi?=
 =?utf-8?B?WktNZUhqNnBENWZMek9qdkxmUXl1QUYvdG90SG1sVEdwWkgzdVM2TlVpVjFN?=
 =?utf-8?B?b3dnRy9HUkFkdzdrU3ZXM2llWTBieXFqSUJ1cW1NZ3JwSUlKdzB0YUY4dFcr?=
 =?utf-8?B?d0NuemhKNUVBdFBPMTMzQmVDVmc3b0hDcTNOZHlCb3lXWHJQc0toSGZVOFFS?=
 =?utf-8?B?MEVZVHJXVlB2akNuSm1nUkZVMWlsSW85ampkV2U1ejI5VmxJaGYrdWhvRE83?=
 =?utf-8?B?cTdra1R0Tm5VSFVPVGkyZ3k5Ykg0RTZ1ZmxRak4vczFKaTlmZVBRb0xTZ2dy?=
 =?utf-8?B?RVRlK0g5QnFkNHkvL2F0NWpZSkZtYm54ZENmc3JkeTF1eVVsVkRjNFFXYUx1?=
 =?utf-8?B?Rmp2M3c1S1ZPWTBXTXIzMklOOVdOVTgybm9TS2wzdkltZFZvMUg2NU1JcGpq?=
 =?utf-8?B?ZkN1WmllL2RwYlY5TmwvWHozN2tuWnNidTQ3a1BoV0N6bkxJMlloQTZVSWV2?=
 =?utf-8?B?bXRwOVA1MGNjdVlVTE5wWVJtT281a29PT2ZmQnJzQ3FzWUlFWEloK2NMdC9x?=
 =?utf-8?B?U0dOOFJXdjZvMGs3d3U0dDFSUFdoV1o3Wjk0Um1FVm1HazZKQjRRMFVpTDda?=
 =?utf-8?B?UkFFSnh2NVplOHd0L3phYTdHVS9qbnJLaFhiUVIzZzBDVGU4eDMzd3h4MTRn?=
 =?utf-8?B?eVVmUmNRQ0VzdTJMRWxKeG9ZaFRrK05hdS9CeCszbmljUTZGaTVTcGpDbDI1?=
 =?utf-8?B?YnlqY1p5VkJjdGtrU21ZNVRscXZ6OFhteEhPMnpRcUpLMkRDSTJvUmVhSmV3?=
 =?utf-8?B?L1dHNzhtdEF1bnNLVmF6YjlJbVJwdHJ0R25sbjRrRk5OSTJNcUdOTlRNWVQv?=
 =?utf-8?B?U3NYSmVLMCtpQjNFU3JwNU9meU9LRDBUQUZDRmc5ZHN4eUtOcUxHUlpRajNn?=
 =?utf-8?B?L3ZKaUMxR2NMM0FnLzdpL281bFgzbUtHbXNMdXFyUkNvYnRZY3FqM2FxUU5T?=
 =?utf-8?B?WVN4eWxiR25KZDJzNUJiRHlWa00zOTgrOFRNRUljcDFmRTFWeWlXSkNYYUVp?=
 =?utf-8?B?MGp3UEZTZC9tOGNuRjJmc2xLZHo0UDJ6MENQelI0VlN3UkE1eVAxWFpYQzNn?=
 =?utf-8?B?ZFMrbnliZld4MkhWeGRaNm9tRFVJUmRTWmR6UlViakR3NXU2SU1OYnlWcnNX?=
 =?utf-8?Q?wC0Q=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1566fbc-c2b2-47d9-3670-08ddaed22d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 01:39:48.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwyWrafYM9L4mbUkLYye5ReNbXMr180ZdbuC4cjMpKXTsmINpgjvrlSmKJVt7egXN6Kx7hq2vdHUSbku4UjbhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136

PiBUbyBmaXggdGhlIGNoZWNrcGF0Y2ggd2FybmluZywgdXNlIGxpbnV4L2NhY2hlZmx1c2guaCBp
bnN0ZWFkIG9mDQo+IGFzbS9jYWNoZWZsdXNoLmguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJj
IEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4IDE3ZTliZGRiOWRkZC4uZGJmYzE5
MWJjZGUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVj
X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4u
Yw0KPiBAQCAtNDksNiArNDksNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvY2FjaGVmbHVzaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2NyYzMyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQo+IEBAIC03MSw4ICs3Miw2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvYnBmX3RyYWNlLmg+DQo+IA0KPiAtI2luY2x1ZGUgPGFzbS9jYWNo
ZWZsdXNoLmg+DQo+IC0NCj4gICNpbmNsdWRlICJmZWMuaCINCj4gDQo+ICBzdGF0aWMgdm9pZCBz
ZXRfbXVsdGljYXN0X2xpc3Qoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpOw0KPiANCg0KUmV2aWV3
ZWQtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KDQo=

