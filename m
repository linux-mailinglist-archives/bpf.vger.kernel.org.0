Return-Path: <bpf+bounces-58840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9096AC2762
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670DC1756EB
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230D29711A;
	Fri, 23 May 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HDZpfMtz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23721296FB9;
	Fri, 23 May 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017072; cv=fail; b=UMQ/0k3FCz1wRO9SG+Yoi9dl7MDH1JBCHGavJz8suNJrbguy72X1UUmWCovaXd0Kx24D27EORWdwM+Iiu2lQCbxCkjJo7VKnO4BJ7f7KkgtN+GhiDfbrIHqJyH7+0a4AOF36yGn8D8ijgY8ahgM9N5MZX/FJU+Lz7D+e74D+mPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017072; c=relaxed/simple;
	bh=7wYcbma0aAnnDKDQmUxkCsywcFHI660583neUsOpd68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dO7kN+2iaTOH4AVc0v6p7t7LrcpETVMmq9ix5mpjCCxU6HyObLkMprdNfW14lbDUEmKrJdUUOucRl05pRRkWqUcQklWVn9x4JR+zXBRkC9NFHcJiszq+7AfOmky7IXmWXplCylj5WK2trxkcliJ+Iuox9UWd9H9jfHjr9h4IOwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HDZpfMtz; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsMs39VlwQg9UNTOhTnuS6MbuHZEb+FU0AezCdJPYTj9FBjSAjvV9tmOEOPLXCi45Y1eZ71YpZLz2UA+TMpf2Oc4p2LHn4HbS9/fDuU/Tyn9Zn5wViXKSp8weBniMCaYxwhyOku6c5opM9da7VO6ozWnu/PtX/pcubUp2LvOAJHBWqsb9zspq/cPYlNb4b+o1c4qAMMkuo9pZvmHZcZLF5RoTE+iozxOqlrw1mqQHzXiHQNmZthHwi7eCB/4hzoyQ3LD2ciX4AK7l5THYiehDQ3x7lnM12fRSB+jbPiWcQO2cX2wkVy+9Pb0xeinvHnkZDe2bPAfHS/SP3i1g9Ed4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wYcbma0aAnnDKDQmUxkCsywcFHI660583neUsOpd68=;
 b=zFQmeFqoY7FX5aeNd0nneIgZvKxa8feYb8i2RZ/RPfz2fnS+P4kLB1q08ZrXf16xgjaVEuE0L3Fmd+L/CttvDT7Ht+b3yom06z6J8LhluWrfqiI/RddepStl/+xCak+Uod/VsvWCroE/Y7CGDpBeAIcLqyNw1fyN8whLLyv7he8aJNUl2fPI3R1xG2hujHGA+AqJ9y/KhL/c42fpRTQ2oHlKii3O5WEoNEXls+CBVB7R95RauA9qmGKeB+sR0i3EmauBSwdjzJqSRCg6HoCF0PGAgtBIWSZmOHG2sKOQ4bQpNj+qbCAqh/Nswe0KZB88F5wk6MXBW37avgHnWnxcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wYcbma0aAnnDKDQmUxkCsywcFHI660583neUsOpd68=;
 b=HDZpfMtzJbs13tbUJYebofM5u6MT/wQG0JQVZxoo9W+nmXgLZkUbgT0nWzE2RISDHNcAfsrMA3T4uB9d5h1cOv6hAOULHwmovNVPEILOIfJAtDZc+bZ7T8al6cP4amndmh5J8poKxNsZT2yleQHeht2BrM/tZVqglu0n8hzxjfuZuFEIBfwLZ3ykcRW0aHOYBweOWgTHou/VuJSGHp5jK2WFyP2sCU8BMn/pAaZBdW/QsSs2Gn4jQ3io8AvfdqERkhewvRy8o1+nOLriB9yx8j27m2DI7FkgeM6w6FEE73SgDSgBsU8b50JhZBwkNBXFh2upm9xY4gIOpMxs6Nq0mw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by LV8PR12MB9619.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 16:17:48 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Fri, 23 May 2025
 16:17:47 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "saeed@kernel.org" <saeed@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "hawk@kernel.org"
	<hawk@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Thread-Topic: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Thread-Index: AQHby2KQeVo8WjjDgkeAFPRDSoSat7PfQmcAgAAGwQCAARyBgA==
Date: Fri, 23 May 2025 16:17:46 +0000
Message-ID: <4f1e6469dc0f3f9dda4741bb3213e0dc86f3805a.camel@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	 <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
	 <20250522155518.47ab81d3@kernel.org> <aC-xAK0Unw2XE-2T@x130>
In-Reply-To: <aC-xAK0Unw2XE-2T@x130>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|LV8PR12MB9619:EE_
x-ms-office365-filtering-correlation-id: e173262b-3ccd-4cf7-4d5e-08dd9a155b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzBhS0pPVkJCVmErU3h5cEsvVlp6TmNMdVNKc3p0bUsrejdaSGREeTduazhE?=
 =?utf-8?B?MXlSSlUvaGpxQ0dVMUZBV2hJTmdKaXNIV2FSYUVXZ2REQWdTMjVZTU4zam1S?=
 =?utf-8?B?QXRYMENUVERvdFFOSGlkeE1LUDk5WE5jdmVUMTlMM3Nia3pxbVh6SFRwa2kz?=
 =?utf-8?B?MllFS000ZHY0R0ZEUnBqRnFsVkExcHFBNm5oc0xkTzBXbHZlZ1pCSU85STRC?=
 =?utf-8?B?eVRwejU0VTU3bEpOQmhwckFYVDVRc3pEK0hPbWhhTGJuQ250UmZ1SlJGTjVU?=
 =?utf-8?B?WmJJZUxsYWZhMEpDWjVVSmF4Q3luMzE5MlVPZ3VDSmVkOGQrbk96YitmQlZs?=
 =?utf-8?B?Yk82eFJvVkpFdG5IbHhpajFhZ0ZsUGNydlE2dzg1VXNGNGM4RU1rNkpkekJa?=
 =?utf-8?B?NktoVjRQOXhwMEdmdHVTcHlZNEQxU1BiNU5DR1AyVE9ib1c1MmdReXIrWFhX?=
 =?utf-8?B?NWF1aEppQm1VOC81cGtWbUZJaFNJYUxFdmVlSUtOQnYzN285aHhYZEFsMVhT?=
 =?utf-8?B?K2JnRVVxb016dW13VEtaMXgzcnVTNURrZWpIVTV3c0ZxbzZ5L3BjZm5oSk1H?=
 =?utf-8?B?TS9rRFJ2SFVuY0Vtc3pOa3k4dDFIaUwzQ0NxemNPQkl2U3lFVWt0ZVRPdTFa?=
 =?utf-8?B?L0dabDYyeWtBd2dqbWxWcCtnbEJXVzdBeVBhcVhieWppVXpIM2Z0Z1k1VkZK?=
 =?utf-8?B?Q1VkTlUwZUpzbkdBU2ZKeHBvQmhTTkQyREhHYTBSMHZBNGYzK3JZZm5aUVN1?=
 =?utf-8?B?ZnZNV2QvMzZyU2gwSFBxdng2SEFzcDFyNXpTaFdmYnRrcWRtZG5VZlhWcXkw?=
 =?utf-8?B?anlDT0FxWUREOW82TTZXYW9DRUpYZUlaYjZ0bm1qU1k1SnFyWFkvZ0JyclBH?=
 =?utf-8?B?eU5ZNXl2WmlCQ05LR08zSGdiR2NlN2dhSk5LMlFRNDVCWFFFa093cFJ0aXhI?=
 =?utf-8?B?dWVTWFBPazZLM1FWdC9VbUhSZ3BkdnMrKzVINHNPeEZiMFZMNXh2dmRWOWk3?=
 =?utf-8?B?Q1RFRFBkK21pSlpBemdFWmJYVStDMUxIRWtVSFhOd1EyWTVWRTRHdXg0bnZE?=
 =?utf-8?B?d3FSS00vTFg0dDlrRjJlaFVnMmVaNHBYV1BDTmpYdDNCMHRzZnNlcXdVajJD?=
 =?utf-8?B?MjcwdHVXWXBCY2VoNHp0Zy9jeG8xcTBsUXRFdHEwOWVkMTRlSnZheTl0a1I2?=
 =?utf-8?B?a2lKMTMyNDVmdTdETzNFREh5Sm96d25Qcmp5aEh3Y2wzbDhHcFhKaTM5L3hv?=
 =?utf-8?B?UStwT1U5ZEtabFNvTVVrUTBSOTJYSk9VUGpQSUJtakphVHBSb3lBUjZ1ckFU?=
 =?utf-8?B?RUc2bkhwUkphdkJpa0FmcUhqMnl5MHpzakVTdHhtbmpaRG81d3B0OHp4UUh2?=
 =?utf-8?B?bzBxbWJrbVlRRTFXSlJrUnV6c1cwdDhmQkg0V3VIWkowRHVUaFhKd1paQ09V?=
 =?utf-8?B?R0hnZ3FEUTV4R01ZcWdZdHNZMEo4RFY1NjhMQ2R0eHltaUQ0OTVqVGRmcnJ3?=
 =?utf-8?B?NTAzQ21meVh2bmF5ZUVraEUxTGl1S2hJLzU3UC8xeXlUYUNiemVLOEtBckRZ?=
 =?utf-8?B?S1BjWkI4S1FCQ3ZDZjJvUzc0UFgxMFJNcHBuWHoxQnFqVWpoSnFoUEpUNjJD?=
 =?utf-8?B?NnlKWEQvSm9McHlFZXFXV0tzK1EvcDQvSnVsRG9lNSs3eDRGeHdFeEFwbk1R?=
 =?utf-8?B?b0RjSEN2a3NSRDB5RkZVcHhrblUwN1VqdFE0b1FIZXBPY3ZtTXB4UXBQTlVN?=
 =?utf-8?B?NitXR0RWVjVOUE5obHlHVm5sTUlyK0FHUnloRlAzeVh0MlJlY202dHJLR3dR?=
 =?utf-8?B?NzNWSFY4SFQ0MkNhZW16VnBrMExwS1FObnRTRCtYbnV2Zk5kNWw1Q09UMEZC?=
 =?utf-8?B?UktYTzAxTXJNSFI2ZXdBWndSTGYvZE9uTE5lb0hsWW5lVHd3M3dGRWdmamF6?=
 =?utf-8?B?M3dnV3BBWVk4NEd2OUljV3Fqck9sQ2lJSjA0YXd3WG96eHFWeVJEOWJmVllK?=
 =?utf-8?B?NUVVa2pVZWt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWNSbkcyV0huQ1htTHZvaDJXTzF1L2MzK1FXdVZMWWdpL0pISEVXcVFRNi9Z?=
 =?utf-8?B?amhiblREdmducXdOV0xBdjh6QjhTK0tFRVN6NDMvRnBwaDBPT0xNSUhIU2t2?=
 =?utf-8?B?T2p4WUNSaU9NL1U1RXpyWTVhNzliczA0eTRGR21QZmh4WmowNk9JbjIrbFlj?=
 =?utf-8?B?MFhtNFJrdDYyd3U5MGhrYUFJQUtPOXh5alVOZDdBU0lCSGE2Um02MWpwRjlC?=
 =?utf-8?B?SUxTek5WZ1JoWEE1NHNGdGlyWlBEM0VxeFBrQWZxeXErNVNYMzVrNmhpVXk2?=
 =?utf-8?B?ci90UjZJRERQd0R0Unh3endRc3BLbzVHTVBydHoreThUd3lZRFdhN2JZVHhO?=
 =?utf-8?B?OEM4dVlZTGI0V1ZFby80VFdXbUdFSE9UcUszc1dZTzNHdWlhOWpTa29ETDNq?=
 =?utf-8?B?YlRwQ2dEVVhJdS8xMHVuajAvdkJGbExxUUpqTUtyRElMUGNML1lvK0h5QThW?=
 =?utf-8?B?N0llRFNyb0pGbXdrazUvY3M5bnk5eEdmenVHUTZWVDF4VFhYTGswTXlOdmQx?=
 =?utf-8?B?SURBdkNZZ3lERmNxSjllUjF5QnMraXVvOTQ2OWpEUmZNRkREV01NdUc2NEZV?=
 =?utf-8?B?dkUyRWdvYUp5aDJrV1hRdGFjNkNkckFyeFkrQ3ZJbFd4K3dna1M2MFlGbytp?=
 =?utf-8?B?VTVIMnRBTEcram5lbXZ5V2RaRC9CU2xIWEh6QzczYUM1aTBJN1VwRDdwVThS?=
 =?utf-8?B?eGIyMFZ5Qlc5Y2pBWGZEM3RrSDBQY2JvUHJsSnVCU09RR2ltWmJnOHpvQnMx?=
 =?utf-8?B?T3ZmSS9EN1BTd2NFU1BvdkJqTUhCdGVKbnVlTUxjUkhyM05QRXpCckU0QjNy?=
 =?utf-8?B?QWsvMlVvaDRzRTRVRlVnOGplMkxNd3psSFZHRlFDeVdJRGVwZm1LajdCY1dp?=
 =?utf-8?B?Y0d2Z3I1RUZCcnhhb3h4RloyMmFCZnRiL0QxSm5mMWpMTWRNelI0VGNYeWIr?=
 =?utf-8?B?aHRldDhiRS9aQXVZTFdTdGQrTnMwRlVSN09YaFZBNXY3MUZwczRhem1tSExm?=
 =?utf-8?B?VmZ0Q3g5MG9YNFhrNldMK1Uvdzg0VG1VVkFVUDNHTDgvTU9IbVhFNlYyR1Rl?=
 =?utf-8?B?OTRyUkZyQlpHSkFIN3o3U21Ra3dFY1dhckZXU09DejZERktrcW96UDhMdUZi?=
 =?utf-8?B?bHpON0paczBvaHR1dGErWEVpbjFPeXRFcHQwS0R1S2tmQWMzNFpBSS82azJC?=
 =?utf-8?B?Qm5XZHpEVGx3d0NXVyt4SldmZkF4V1F6OUlPNHFnR2ZhMWlqQUhDMTV0UVZO?=
 =?utf-8?B?M1ZrSWtlMjAxS2hFKzFLUnJSN3orMGNQb2R2cDJuRGl6dlpNM0wwSjYxYTQz?=
 =?utf-8?B?bm5HRjJmUk1KSXVYUENJOWx5YUVTRkJmK3VFcVFYNlE4eFNEZ2haUVllUUlm?=
 =?utf-8?B?MllJK1pvNS9XcWp0Y3o4RFRQcWZDTTM4aXVjdU9qSzg1SkxUMlFXc21hNFUx?=
 =?utf-8?B?WXd4KzZOdzYwQkFzQjJDNCtqaVE2NU5yNm1oL2RjZ1I4a1N6L0psa2RSQWhx?=
 =?utf-8?B?ZFVZbHlBWWlHa1RZODhVL3Z2NGswdldWUTBnekFnTzV1SU9rcXdzSjZlQ3E4?=
 =?utf-8?B?cTh0MjN2WnE3aXNzcEkraTFhRU4zbXBwZmVMZm0rdVFBUjFlOXJXRUJwZWdz?=
 =?utf-8?B?NVdCemRzK0dER3QzSmlsTWROYzZaenVpbHI0UXIvdkVxYXZOYmVqdEpKb3ph?=
 =?utf-8?B?M29VaWxrUTZqNmptcTA0Vk9CUktZN2E0N21CbnU1TmQvRnZKZXdrcmsvTGJl?=
 =?utf-8?B?MFoyNm1Vc2Y3WW94S1B4U3lTbU44cGFZaFRFcEh0WHJFSWZUYXBFSTVLcWdt?=
 =?utf-8?B?WGJEazF4dDc1aWM3YlgzWk56d1crQlAvS2wvaG1Ja0VLbHlSOUQ4NTBzRXYr?=
 =?utf-8?B?TTZVNERDcTZsZ0FMaDd5S21JdDlGWklPdWgvVmVFTy9VUVlVREpuWWJIQlB4?=
 =?utf-8?B?STRvUWxtMmlPRkdKcDVXblhLV2E1MnZEMmoyOWZwMU9jWXZRYWsxR3BmT0py?=
 =?utf-8?B?NXpOUVprVDBrRGxEanVDMmw4MVFJb2pJbXRrUCt0NEVOMzNObTBDWUNucHov?=
 =?utf-8?B?MldCMmwxK3AyaUk5ZHZHcUlzSjNQYURaREdIVk5aVlZLYVdSL3JHbnJBL0Vo?=
 =?utf-8?Q?ML2V4SWg0WPnWrQa4uEyGz9hP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05DB87084CAE0D4BBF4B530A8BB21A81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e173262b-3ccd-4cf7-4d5e-08dd9a155b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 16:17:46.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8d+tce9GmWyiUDw0ofnEEG+Jd6tmXrlHbBzqn3gDGXY7xWuEnSvXxPYqrpcs3N5v2yQ9JYMFOKvbajD4gvFCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

T24gVGh1LCAyMDI1LTA1LTIyIGF0IDE2OjE5IC0wNzAwLCBTYWVlZCBNYWhhbWVlZCB3cm90ZToN
Cj4gPiANCj4gPiBUaGUga2VybmVsX3BhcmFtLT50Y3BfZGF0YV9zcGxpdCBoZXJlIGlzIHRoZSB1
c2VyIGNvbmZpZywgcmlnaHQ/DQo+ID4gSXQgd291bGQgYmUgY2xlYW5lciB0byBub3Qgc3VwcG9y
dCBzZXR0aW5nIFNQTElUX0RJU0FCTEVELg0KPiA+IE5vdGhpbmcgcmVxdWlyZXMgdGhhdCwgeW91
IGNhbiBzdXBwb3J0IGp1c3Qgc2V0dGluZyBBVVRPIGFuZA0KPiA+IEVOQUJMRUQuDQo+ID4gDQo+
IA0KPiBJIHRoaW5rIEkgYWdyZWUsIEFVVE8gbWlnaHQgcmVxdWlyZSBzb21lIGV4dHJhIHdvcmsg
b24gdGhlIGRyaXZlcg0KPiBzaWRlIHRvDQo+IGZpZ3VyZSBvdXQgY3VycmVudCBpbnRlcm5hbCBt
b2RlLCBidXQgaXQgYWN0dWFsbHkgbWFrZXMgbW9yZSBzZW5zZQ0KPiB0aGFuDQo+IGp1c3QgZG9p
bmcgIlVOS05PV04iLCBVS05PV04gaGVyZSBtZWFucyB0aGF0IEhXIEdSTyBuZWVkcyB0byBiZQ0K
PiBlbmFibGVkDQo+IHdoZW4gZGlzYWJsaW5nIFRDUCBIRFIgc3BsaXQsIGFuZCB3ZSBzdGlsbCBk
b24ndCBrbm93IGlmIHRoYXQgd2lsbA0KPiB3b3JrLi4NCj4gDQo+IENvc21pbiB3aWxsIHlvdSBs
b29rIGludG8gdGhpcyA/IA0KDQpZZXMsIEkgd2lsbCBhZGRyZXNzIGFsbCBjb21tZW50cyBmcm9t
IHRoaXMgcm91bmQgYnkgdGhlIG5leHQNCnN1Ym1pc3Npb24uDQoNCkNvc21pbi4NCg==

