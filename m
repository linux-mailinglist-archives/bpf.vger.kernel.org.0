Return-Path: <bpf+bounces-34087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504A292A574
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41E71F2227F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22412143749;
	Mon,  8 Jul 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="zSxyLYf1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096F13EFF3;
	Mon,  8 Jul 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451581; cv=fail; b=gJsqz9jVIosC3YAuGVh6US5a4OpojJC2hjBX6OfL9XIgwXP8Gta2DcBZYNZn+hCr4FZOuEuMGDw0zEyKbiNob8vU2sAC+zToJ7po8MEVPmikUNvx7oMm+cZydhLdh1xMMT/VDYnMZYDEtOvW1mLd5ZSEvT0I8lV1YuluNgm4c4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451581; c=relaxed/simple;
	bh=NSuUj6jTqkTPdRGOnj2CjnNA2tVp2NYOk8z1QcDvI0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLaB/Vi5PCFCq7+FI2oJQK7/rnrdL7FoqR8lpHF6fJpwSbnv0xA+LKH4lhVsOSnY5VyvQdQPayfgAozQ7T/yCt9XLkPwmfwyVXvc2a1HS/41pdUS/UGBCEkPb8QQJBwB5Tq/98EGA1zzHcksAbwvtFtoq8jWSG+c/r4CkvSjMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=zSxyLYf1; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXcXf+F7RHck0xAeosyUm+byyniqMIxBHigBAbFuaTodwSuR2RgfaDY3Rin7qemC05PabOr0/CzZpH6LB86lLHzK/M0qNYAd/3qmvQYm2zgUOi2acugfdkMh8P3qYgR3HWM7ogMmznabDR2G7VkUTul7aAmGyfdof8zFujPJ50g999s6sr0zf8IIqW9RcFa72YiovhnI8wQVV/JhvwFNDMbaKkGLV6gXy/dcFA+VkcHlfwnfQYlEqQbMDZY7bFhEi9UPxMmKD7ernVV0mBVhykcksa9emziJbKTCU+gPEC1FueNGim5I82FCnhN9PI+3xB8DkHzdnq9PFscdMPTDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSuUj6jTqkTPdRGOnj2CjnNA2tVp2NYOk8z1QcDvI0w=;
 b=GszZnmxte5Zc3dSjv40xas0qVzqa2bPCjrvA15tz7IuN4usnS3SDKd5RyxRvcVaGeqXnK9KdqO4ON3+8Tg/JpVm8mCtS2CWHn5uGQGRCf+eUWF41kyIHhD2yijR3GxYcWbk3HxM6xIQJlDFnTqdPKFZUCslIkMaqA6R8j+SVsBycW2vugJzmPueaYKjjlNsQpLhvtY/2fUifOvasFkBQ0rdtM+Lb6+vX6hQu2OZLDgQvmMlbCiP8s8IlmkNPqQSJQ3aUQfJ4VnePSwmW22sTp350Fpy2toFOSk697Nbx5T9i+IubrpJoCuICXIX+WO8tNGSQOerw7kAdkjjk5sBZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSuUj6jTqkTPdRGOnj2CjnNA2tVp2NYOk8z1QcDvI0w=;
 b=zSxyLYf1MEEDX3FQUdTXWDiD60PEyKcKBtkTY7YLwnI/vcfdN/fH0YIg6gOyfOysDKyUhC4MQblMOnrlDi2b/C+bA1HHv04nf/2TJnChRiHJoJTWs2keTker2jggFlqa8Bj1lHgA1508MhX0DfQm09CA+n8wpFHwQIrZlNN0nu0ozIN4ybA65hVkOMus4RDbKE+QwECM+bkBgVE5zC5kZIkkIvovWIMrtOiOMkLFxKJ/AvMBNp2ISunUzvrdqErb1vqbF6JQpTqCZtyNgCsjYYe8dAOrYZRhtpqZK0LsPBiS/ikHYF10cEY2rfB0VoqdbMWAyf1W5bUxyutu+E8bQw==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AM7PR07MB6787.eurprd07.prod.outlook.com (2603:10a6:20b:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 15:12:56 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%6]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 15:12:55 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Greg KH <gregkh@linuxfoundation.org>, WangYuli <wangyuli@uniontech.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "song@kernel.org"
	<song@kernel.org>, "puranjay12@gmail.com" <puranjay12@gmail.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"illusionist.neo@gmail.com" <illusionist.neo@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>,
	"paulburton@kernel.org" <paulburton@kernel.org>, "tsbogend@alpha.franken.de"
	<tsbogend@alpha.franken.de>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "deller@gmx.de" <deller@gmx.de>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"iii@linux.ibm.com" <iii@linux.ibm.com>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "guanwentao@uniontech.com"
	<guanwentao@uniontech.com>, "baimingcong@uniontech.com"
	<baimingcong@uniontech.com>
Subject: Re: [PATCH] Revert "bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()" for linux-6.6.37
Thread-Topic: [PATCH] Revert "bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()" for linux-6.6.37
Thread-Index: AQHaz1JvmhkZvbTHdkOR2W9HlG+2VbHpb4AAgAFx/oCAAebSgIAAK6gA
Date: Mon, 8 Jul 2024 15:12:55 +0000
Message-ID: <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
 <2024070815-udder-charging-7f75@gregkh>
In-Reply-To: <2024070815-udder-charging-7f75@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AM7PR07MB6787:EE_
x-ms-office365-filtering-correlation-id: e4e9a7c3-5618-490c-73b1-08dc9f60720c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWpDaE01Si9oc2R5TC9mK3orclRlUFhyMEdnL0Y0Z2Q0S3Y1QURkaXJSQ0s0?=
 =?utf-8?B?bTFoMnU3ZzNheEJHdHRhWjZqZ2V4RjlpalJmZFhRU2F0TkhJYmxweUhsWWwz?=
 =?utf-8?B?c3dFK2hrcnpaNy96VUdIa3JURk1zaVpyTDFqWTlMNXNXcjQ4cEVidnlzdk9D?=
 =?utf-8?B?L3ppV09abGZqZVRKai9MSnhuYUlPVUY0aGVlVTFiZHVFMDRhSkxmSkFTWDNN?=
 =?utf-8?B?dnB4ZzJnM0x5Q1dISkR2ektWVTdRVzU2Rjh5V1R0amF2SGZiMFloOUgydUFr?=
 =?utf-8?B?bWl2emdSRU9RZGRNL1REQm9wN2lPSU5jRVFmZGcyK2tPSWFiM1hIVUlSSWll?=
 =?utf-8?B?YU9ocWtHRjRWQWJpdjJyR3dxL0hKUGFhUHllMnh1MXN4clFUSWxoVG9MSHRy?=
 =?utf-8?B?SWFoUTN5NE94UmRKRHFmVWhScW1PSk5WaEl2OTUweldZQ2VOYnpWTGJPZnZw?=
 =?utf-8?B?V1pSZUpKYmFBMHFhaHBUYTI0L0o5dUxwTjFhNDZhT2RBb1lNOEZwSk4xSWVH?=
 =?utf-8?B?TDgzbG00U0xCcHc3S1VlTXBjN3pVMkovY2s0Y0x3dFoxOUE4d1QzM1ZwWFFG?=
 =?utf-8?B?YkEwWmp2WGtDb0ZRYTNKbEJWRUV5ZUhHUnNIZE44eGRSSlM4Mm5zTStqNW5h?=
 =?utf-8?B?VWhtaTd3dTVJTnVXMHJ6TWNCSWwzVDBad3Z4RzR2eFl6bGNWcFpIS0tDQkIr?=
 =?utf-8?B?c0kvUTZPL3JnMUs1Nm5jL2IvdHZVM3JGYVJVb04wengwMkllblZEa0VLc2h0?=
 =?utf-8?B?emg4TUl3K1dGQlYweEtRUW1QTStJdzdRNU1Cd29oVWZUbFpUSVNqSy9YY2JN?=
 =?utf-8?B?VmhVWmNvS214VGxFV2l5U3hZY2szYjJIVkdjaGpCNitRbTNPL09mRU1pRStB?=
 =?utf-8?B?V3hZWkNqWUJGV2V6R2lTUEFaSUFyM0FrdDVCWTc4NW5BQkovK0hYSkpsYjZD?=
 =?utf-8?B?REs1dS9rdHVSbDNlYXI5dFlIdmNWbXl2M3RSQ3pPMkNWVHNnK1JndU14WGtj?=
 =?utf-8?B?SFF2cUkzQThOSVB6WGluQm1STXRiWWUvWVErOE9neW5hcEFNb0lEZzBxZ2w5?=
 =?utf-8?B?Tk9hTHkwQTJoekp0dFhnM25YcGwwOFNmTUJzbFk1RzJHbE1qazg0enB6M1cv?=
 =?utf-8?B?di92YWZ6b0VEbFJWMGhzcmhlaW9BeFpMckxWVUtlU0pIRnk4ejlOa3BHRWsv?=
 =?utf-8?B?c3hPTy8vbUd2eWxRcVdYWExOWm1rNWUyK2tLRGt1Y1V0bWQwRFBjci9hZ3Zj?=
 =?utf-8?B?ZGlVajNhaWY2ZWtiNmdwNE95SndRZjE3c0FKVTduUS9zbnhQU2pSS0RPUkM3?=
 =?utf-8?B?eERsTFlVRmFhRnFnVkJDRUVkTFNZL1U2YVpVczg4RkF4S09sMk5HVDNmRVlB?=
 =?utf-8?B?YlV0Sm51YjJ6UzRCZTlMYUJRY2JHSnJJSVpUaTBXbmtyN2JjSWU5RDB0OXRV?=
 =?utf-8?B?ckNlOHNka05WRzZ3MVowZHpEeVlxbXUweGppQkVsS1hMcElhcUUvL0dyaUhw?=
 =?utf-8?B?N1d5Y3R5dzRYWk9wVldod2Y1T1RLMkZjRkx2d05BempPL3BValV2NVl1NkNO?=
 =?utf-8?B?bmd1NWJQTnVpeWJhdEJMUjQxSzRDbVFPTG1vdUZYZzNoMExISEl4NGVna0ly?=
 =?utf-8?B?OERPMlVpZWxEM3QybVh4dm5wb3YzYmpqck1aSmw0bFRTbUJkbVdZNkE1OGw3?=
 =?utf-8?B?OEs0QUQ5UFVGaURCWWpRNnBnais1Q1dlRXVkakJFYk1nclJYZGw2cXVtVGJJ?=
 =?utf-8?B?S25ndnl2LytQOE5NTUFIcEdiRlpmQ2hWMnllcitvdGJMMTFZTENRNEgvRTls?=
 =?utf-8?Q?cUzdsX7qoa7pYLDoQfBJ1u8htW3BvkjXGR+/8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUdUKzFkcFR5ZmRWSVQvNm5xUWVmSGNzU1ozM1JSQ1U1bU5tRkMvNkdHdnF3?=
 =?utf-8?B?U2MxWS9aTzNBbFFnTGZTMSs2dVMyVzhERXI1d1dKa0hVUy9DZ1lJdFpreU5q?=
 =?utf-8?B?Q3FCS2YvMEphVGJ5eG5qektQeVZxTUpSa2VtcW1UNkhNZHkyTUxhaVozVkIv?=
 =?utf-8?B?d2ZsRzNnWmJhUkVXU28wMmk2RmFOUndwbXZIRzNHNkFleTlSUktvU01hVzRP?=
 =?utf-8?B?ZS8xMWJtS2ZlMS9RUVNpYTdpRVpDQTdZQ3dXRkRscGNBb01QTEVRUm1zSk1J?=
 =?utf-8?B?RmFBdFFOUkdrUnQxcnl4L01meDlTNVRxbHJZU1RYa0xlcnJwOXZyejFvRUky?=
 =?utf-8?B?YktTV09RL3QwUHd5bUdIb2trZUtjOHlqYk9JTkRPcGoyUEFKTGVlTjc5TjRZ?=
 =?utf-8?B?a010WkQ5WWRYUndWL21jdEdQQmlpNGtJM2RTMThOUUdpWjRTWXphb2cwUndx?=
 =?utf-8?B?ZzhrcWdWR1lWOEx5U2NUY1c1NUNuMnVMWXU4SzJraGJkUFpaVkMwQTNWNDBR?=
 =?utf-8?B?UytlSWYrdmI5ZS94SVdQbXRsaDZ5WjdLWWRpZHp5UUhEUmJacnlLblJEZUpp?=
 =?utf-8?B?TGdFTE1KbEZCNDdiU281dHVFU3ZJSWVUSEhmUXEvM2RTZVZJMFlYQVRNSGVk?=
 =?utf-8?B?UkxOMkdtUDBGVzJLam1wakpMNjFpOWN5MU1BNk9CV0NTTEVPc2h4UzdLbWMv?=
 =?utf-8?B?UmU1RHFvdUpGQ0lETFAxU3ZqeEw1eVFsZnZvVlNGbkFleUlCa1huZkF0K1N6?=
 =?utf-8?B?aG1DT1o1VEtnNXI0SGI1dE4vMUVZYjlNTXk1R1Q1UUh5Vk5Za0UwVnVNQ3h0?=
 =?utf-8?B?ejVheXorTWVTVHBMV1BrZ2Y4VzRENHdtUFVvblRoYlRQeHlWVVhjVmliK0ly?=
 =?utf-8?B?M3hwVnUvWkhMSHB2WDdmMHAycC9DdEdkSlJOaG9qYldaMnliYlh0Y3UzZDB1?=
 =?utf-8?B?UFF5TmVvaVdtS0lyeVkzNFRVR01pN2VIOVVRcVNCL2dtbFA2eWY1WEZ1eC9S?=
 =?utf-8?B?Z2RsS3Y4TzJiMmxZOXlJT2NsblA4bzVLNk1oRS9Ta3pwZDM1Si83aHFtL1Ur?=
 =?utf-8?B?aHJIOFJGZUxLd3VpNDdVemRJeGYzL0dKNHBuQk1RSWUvRnZtSy9NSE5zbHl6?=
 =?utf-8?B?dWdVeDZDK0F4Z09aQ1U2czhrZkRvSC9DL0JtZVFZOTdvQmV5NTF3L1p3SDdI?=
 =?utf-8?B?TkdtbHFnaUtobnMxWEVyMWw3elQ0Y0ZWSXA5MWVrc0JzR1p3MmFhYmpYMXBD?=
 =?utf-8?B?T1NEYzFDVVIzUWJ5d2hQZ2ZkVXUyYStXdmtGQzN6VUl0cHBUdEhyb1ZKZ2xD?=
 =?utf-8?B?OXhyZHZjeDNCQmhhdjhucm85RCtpbHd5ViszRlBSYU85eVZXMmphTjhSQ1BR?=
 =?utf-8?B?azJ1dzV0RmtMazBpZ3dQV3VWT0YzYVRZUWdVQlZuVE45eURkMUFlVk5lU2E4?=
 =?utf-8?B?WFI2WmJjMjVSN0txMjd3bEVwWnY3SkpMOHFERXpnaHFrQXhOV1d0K2JvUkRs?=
 =?utf-8?B?cFk1ZUxQVC9UamQrQlNmZFYwUjR2TjZpdC9PZ0V4eWNyZFkvK1QzWVYwOWQy?=
 =?utf-8?B?OFVwaTNnM2Z5MVllWENVbFlKdGNUSzJlVDRDM3lRcEhxeWFUS0ROWE9KdGZv?=
 =?utf-8?B?NC9lV3l2QmdTekJqbGV6R1pkZVRUT2Q0ZWdQMGtHeGxFOSt0OGNDc3EwOGxu?=
 =?utf-8?B?QkFaT0x6YzdvT0w4QjRCRldsdXVKY0RDeE53dmtyazBqRTd5anhyRytmdVE0?=
 =?utf-8?B?RFJjaFU2WDUwVTgxRUFqdDljVnlVTUNiRGRMOGpMODRzcUZoMS9ydVBGdS9V?=
 =?utf-8?B?SHZyMFQzb1doZ3Y5R1YweEt1ODFkT3JFczJxUERUZmdpVFNVMEMwMUxJUTkx?=
 =?utf-8?B?aHhYQkhZVVVhRWIvRDdTRWIzamhzMm03NEExVUR2cVVvTlc3d3BYdnAxY2NE?=
 =?utf-8?B?dTd4cXc5V2RCd0QxUTdNNXNjNUs1anJzMDlPMC9VUVF4SURkUEl0R0dKc3Fh?=
 =?utf-8?B?YzZ5K2RWdHVlSjhKQi9PRWJFR1E3bzNZcUtmcjBRY1dtbVppb0prMGMwajQ1?=
 =?utf-8?B?czJsYVJBdFpDS3ZON2hVZGF5MkhLZWpYWmxOdnZjTS8yUWZnNmV2UngxL1pJ?=
 =?utf-8?B?THBIL3piaGRZYm11d1NKYjBXbkw0OCsrV2hFQng2eGZDd0JvTkJsOVQxdktr?=
 =?utf-8?Q?GRwaUhXe7NnB39d47jgCeu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F86B29AF6958014596DBEBFD9AB2B684@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e9a7c3-5618-490c-73b1-08dc9f60720c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 15:12:55.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlVP8j1X7Ywv5n15awaUTCxNlf4nJxgKsLr5vPkF//qKMNRxq2aV1Q0tLrpzYXKzUue5FjnCP3H8L6Ke7Eh6RD1Ta7Bx7xGece9dXy0vBJtqfjCfXmvyoT+hIefMqAk+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6787
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 88.124.70.171
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AM7PR07MB6787.eurprd07.prod.outlook.com

DQoNCkxlIDA4LzA3LzIwMjQgw6AgMTQ6MzYsIEdyZWcgS0ggYSDDqWNyaXQgOg0KPiBPbiBTdW4s
IEp1bCAwNywgMjAyNCBhdCAwMzozNDoxNVBNICswODAwLCBXYW5nWXVsaSB3cm90ZToNCj4+DQo+
PiBPbiAyMDI0LzcvNiAxNzozMCwgR3JlZyBLSCB3cm90ZToNCj4+PiBUaGlzIG1ha2VzIGl0IHNv
dW5kIGxpa2UgeW91IGFyZSByZXZlcnRpbmcgdGhpcyBiZWNhdXNlIG9mIGEgYnVpbGQNCj4+PiBl
cnJvciwgd2hpY2ggaXMgbm90IHRoZSBjYXNlIGhlcmUsIHJpZ2h0PyAgSXNuJ3QgdGhpcyBiZWNh
dXNlIG9mIHRoZQ0KPj4+IHBvd2VycGMgaXNzdWUgcmVwb3J0ZWQgaGVyZToNCj4+PiAgICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDcwNTIwMzQxMy53YnYybnczNzQ3dmplaWJrQGFs
dGxpbnV4Lm9yZw0KPj4+ID8NCj4+DQo+PiBObywgaXQgb25seSBvY2N1cnMgb24gQVJNNjQgYXJj
aGl0ZWN0dXJlLiBUaGUgcmVhc29uIGlzIHRoYXQgYmVmb3JlIGJlaW5nDQo+PiBtb2RpZmllZCwg
dGhlIGZ1bmN0aW9uDQo+Pg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIGluIGFyY2gvYXJt
NjQvbmV0L2JwZl9qaXRfY29tcC5jICsxNjUxDQo+Pg0KPj4gd2FzIGludHJvZHVjZWQgd2l0aCBf
X211c3RfY2hlY2ssIHdoaWNoIGlzIGRlZmluZWQgYXMNCj4+IF9fYXR0cmlidXRlX18oKF9fd2Fy
bl91bnVzZWRfcmVzdWx0X18pKS4NCj4+DQo+Pg0KPj4gSG93ZXZlciwgYXQgdGhpcyBwb2ludCwg
Y2FsbGluZyBicGZfaml0X2JpbmFyeV9sb2NrX3JvKGhlYWRlcikNCj4+IGNvaW5jaWRlbnRhbGx5
IHJlc3VsdHMgaW4gYW4gdW51c2VkLXJlc3VsdA0KPj4NCj4+IHdhcm5pbmcuDQo+DQo+IE9rLCB0
aGFua3MsIGJ1dCB3aHkgaXMgbm8gb25lIGVsc2Ugc2VlaW5nIHRoaXMgaW4gdGhlaXIgdGVzdGlu
Zz8NCg0KUHJvYmFibHkgdGhlIGNvbmZpZ3MgdXNlZCBieSByb2JvdHMgZG8gbm90IGFjdGl2YXRl
IEJQRiBKSVQgPw0KDQo+DQo+Pj4gSWYgbm90LCB3aHkgbm90IGp1c3QgYmFja3BvcnQgdGhlIHNp
bmdsZSBtaXNzaW5nIGFybTY0IGNvbW1pdCwNCj4+DQo+PiBVcHN0cmVhbSBjb21taXQgMWRhZDM5
MWRhZWYxICgiYnBmLCBhcm02NDogdXNlIGJwZl9wcm9nX3BhY2sgZm9yIG1lbW9yeQ0KPj4gbWFu
YWdlbWVudCIpIGlzIHBhcnQgb2YNCj4+DQo+PiBhIGxhcmdlciBjaGFuZ2UgdGhhdCBpbnZvbHZl
cyBtdWx0aXBsZSBjb21taXRzLiBJdCdzIG5vdCBhbiBpc29sYXRlZCBjb21taXQuDQo+Pg0KPj4N
Cj4+IFdlIGNvdWxkIGNlcnRhaW5seSBiYWNrcG9ydCBhbGwgb2YgdGhlbSB0byBzb2x2ZSB0aGlz
IHByb2JsZW0sIGJ1dGhhcyBpdCdzIG5vdA0KPj4gdGhlIHNpbXBsZXN0IHNvbHV0aW9uLg0KPg0K
PiByZXZlcnRpbmcgdGhlIGNoYW5nZSBmZWVscyB3cm9uZyBpbiB0aGF0IHlvdSB3aWxsIHN0aWxs
IGhhdmUgdGhlIGJ1Zw0KPiBwcmVzZW50IHRoYXQgaXQgd2FzIHRyeWluZyB0byBzb2x2ZSwgcmln
aHQ/ICBJZiBzbywgY2FuIHlvdSB0aGVuIHByb3ZpZGUNCj4gYSB3b3JraW5nIHZlcnNpb24/DQoN
CkluZGVlZCwgYnkgcmV2ZXJ0aW5nIHRoZSBjaGFuZ2UgeW91ICJwdW5pc2giIGFsbCBhcmNoaXRl
Y3R1cmVzIGJlY2F1c2UNCmFybTY0IGhhc24ndCBwcm9wZXJseSBiZWVuIGJhY2twb3J0ZWQsIGlz
IGl0IGZhaXIgPw0KDQpJbiBmYWN0LCB3aGVuIEkgaW1wbGVtZW50ZWQgY29tbWl0IGU2MGFkZjUx
MzI3NSAoImJwZjogVGFrZSByZXR1cm4gZnJvbQ0Kc2V0X21lbW9yeV9yb3goKSBpbnRvIGFjY291
bnQgd2l0aCBicGZfaml0X2JpbmFyeV9sb2NrX3JvKCkiKSwgd2UgaGFkDQp0aGUgZm9sbG93aW5n
IHVzZXJzIGZvciBmdW5jdGlvbiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKCkgOg0KDQokIGdpdCBn
cmVwIGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8gZTYwYWRmNTEzMjc1fg0KZTYwYWRmNTEzMjc1fjph
cmNoL2FybS9uZXQvYnBmX2ppdF8zMi5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIp
Ow0KZTYwYWRmNTEzMjc1fjphcmNoL2xvb25nYXJjaC9uZXQvYnBmX2ppdC5jOg0KYnBmX2ppdF9i
aW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KZTYwYWRmNTEzMjc1fjphcmNoL21pcHMvbmV0L2JwZl9q
aXRfY29tcC5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KZTYwYWRmNTEzMjc1
fjphcmNoL3BhcmlzYy9uZXQvYnBmX2ppdF9jb3JlLmM6DQpicGZfaml0X2JpbmFyeV9sb2NrX3Jv
KGppdF9kYXRhLT5oZWFkZXIpOw0KZTYwYWRmNTEzMjc1fjphcmNoL3MzOTAvbmV0L2JwZl9qaXRf
Y29tcC5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KZTYwYWRmNTEzMjc1fjph
cmNoL3NwYXJjL25ldC9icGZfaml0X2NvbXBfNjQuYzoNCmJwZl9qaXRfYmluYXJ5X2xvY2tfcm8o
aGVhZGVyKTsNCmU2MGFkZjUxMzI3NX46YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcDMyLmM6DQpi
cGZfaml0X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQplNjBhZGY1MTMyNzV+OmluY2x1ZGUvbGlu
dXgvZmlsdGVyLmg6c3RhdGljIGlubGluZSB2b2lkDQpicGZfaml0X2JpbmFyeV9sb2NrX3JvKHN0
cnVjdCBicGZfYmluYXJ5X2hlYWRlciAqaGRyKQ0KDQpCdXQgd2hlbiBjb21taXQgMDhmNmMwNWZl
YjFkICgiYnBmOiBUYWtlIHJldHVybiBmcm9tIHNldF9tZW1vcnlfcm94KCkNCmludG8gYWNjb3Vu
dCB3aXRoIGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oKSIpIHdhcyBhcHBsaWVkLCB3ZSBoYWQgb25l
DQptb3JlIHVzZXIgd2hpY2ggaXMgYXJtNjQ6DQoNCiQgZ2l0IGdyZXAgYnBmX2ppdF9iaW5hcnlf
bG9ja19ybyAwOGY2YzA1ZmViMWR+DQowOGY2YzA1ZmViMWR+OmFyY2gvYXJtL25ldC9icGZfaml0
XzMyLmM6DQpicGZfaml0X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQowOGY2YzA1ZmViMWR+OmFy
Y2gvYXJtNjQvbmV0L2JwZl9qaXRfY29tcC5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFk
ZXIpOw0KMDhmNmMwNWZlYjFkfjphcmNoL2xvb25nYXJjaC9uZXQvYnBmX2ppdC5jOg0KYnBmX2pp
dF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KMDhmNmMwNWZlYjFkfjphcmNoL21pcHMvbmV0L2Jw
Zl9qaXRfY29tcC5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KMDhmNmMwNWZl
YjFkfjphcmNoL3BhcmlzYy9uZXQvYnBmX2ppdF9jb3JlLmM6DQpicGZfaml0X2JpbmFyeV9sb2Nr
X3JvKGppdF9kYXRhLT5oZWFkZXIpOw0KMDhmNmMwNWZlYjFkfjphcmNoL3MzOTAvbmV0L2JwZl9q
aXRfY29tcC5jOg0KYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KMDhmNmMwNWZlYjFk
fjphcmNoL3NwYXJjL25ldC9icGZfaml0X2NvbXBfNjQuYzoNCmJwZl9qaXRfYmluYXJ5X2xvY2tf
cm8oaGVhZGVyKTsNCjA4ZjZjMDVmZWIxZH46YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcDMyLmM6
DQpicGZfaml0X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQowOGY2YzA1ZmViMWR+OmluY2x1ZGUv
bGludXgvZmlsdGVyLmg6c3RhdGljIGlubGluZSB2b2lkDQpicGZfaml0X2JpbmFyeV9sb2NrX3Jv
KHN0cnVjdCBicGZfYmluYXJ5X2hlYWRlciAqaGRyKQ0KDQpUaGVyZWZvcmUsIGNvbW1pdCAwOGY2
YzA1ZmViMWQgc2hvdWxkIGhhdmUgaW5jbHVkZWQgYSBiYWNrcG9ydCBmb3IgYXJtNjQuDQoNClNv
IHllcywgSSBhZ3JlZSB3aXRoIEdyZWcsIHRoZSBjb3JyZWN0IGZpeCBzaG91bGQgYmUgdG8gYmFj
a3BvcnQgdG8NCkFSTTY0IHRoZSBjaGFuZ2VzIGRvbmUgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBp
biBvcmRlciB0byBwcm9wZXJseQ0KaGFuZGxlIHJldHVybiBvZiBzZXRfbWVtb3J5X3JveCgpIGlu
IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oKS4NCg0KQ2hyaXN0b3BoZQ0K

