Return-Path: <bpf+bounces-59192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38655AC7230
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 22:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9851AA22224
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308B220F4C;
	Wed, 28 May 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IoIOi2M6"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021128.outbound.protection.outlook.com [52.101.62.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042C20FA90;
	Wed, 28 May 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464154; cv=fail; b=dJ0SfSYxxVqS53ySCDZ5D277yiHLIFaGpzm1JoYy3N4A9LC34C5KscZ64QkDAdu9EFTm343yqfTqlrXoLCtuv1fOyYBhnKdMn2zcTnAvJl3OTNVS68EyByS5TkIJgCrxl25+dNimBKHxPjEBiHDcrcz6YhsyeOKYkSxSf0AzRR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464154; c=relaxed/simple;
	bh=wZwNtXGs7KORAyTOB8yIMn55rqMhym3EM0JdQKzkZrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7tA8XhQZ6h46Ohup1RALWZqsUIrUO2P9TzKbACz957hK8rfSIrQH+jyoxxEcBiUHbE32BovOn8SXGuCQYq5OT4dsrFW5QymKB4slw7Y32yiNKQ7z82pA3gmL8cVjzaqvZDWURjM7+rfKufx1E28ZVRL+V1qixRqgP+ctfud3zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=IoIOi2M6; arc=fail smtp.client-ip=52.101.62.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh/33tRbypyedaLbR0hdsS+feQ0iyBOBfRkhawuoF4/E8v3bCbHFQrHC6EqDyZtGe9gj2RnUhkhuR+oxwP9eQQuNymI266oZAstqaULtZwnKC0fx4Ppjy2eECroOJ14oouVWHBGfRzYs+Hio6RSPkk8DeSap9p8zUFH0V6NPvZHaE8jRwIdCpu6A3wPTfLuCgoXCVCfVrlWnrcRhiHliRCzUNCPu/ZMjqTq527fscRdvgIplDhc3WjNDWNpsMintxeQevbsVo+Z30wH8c87QmVNv7ucE90/r4Zu7Aq0pjQAsE4Z94xqepeWdj8JoOCmHNiyLDoICkYLJtisgteA1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZwNtXGs7KORAyTOB8yIMn55rqMhym3EM0JdQKzkZrg=;
 b=o38vqgHUonVUdMiLGnV6kMQ3bn2oc/Yskmx+t9ruPop3ysF0nuv8hf725VmD+npA5bGd5Y9Xo4vax99ltmmOwB1TpgR9ydsezIf7SVZ6X3cqgImVucuvOMRJLDKyCuG2Vl0Vmm0GSAV5kpSaBj8gb1OE2OSqbANMYVblZYLxW2zCiWDM0h2Ozs8r4Q+SKLaAdEpYbG4gt5LwFF2CmeBJF+EHcKWNFPEJSST8Nk5ysSP8xQ2dh/IGtCMi42ReZdAvqGUCAW9IQBrP7OQv1BdXZmpFOgyKFGkQo9/lDisuKblKsvoFI96JDspt/KR1I5h/0zQ9cK3guZpJwwqXNGXkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZwNtXGs7KORAyTOB8yIMn55rqMhym3EM0JdQKzkZrg=;
 b=IoIOi2M6ie8mNy3j/DbGXi6B1wcPT0Uv/0YZxSa42liajp1dqL6iR2L2oua/Sww6WRJpf5lb7WLq+WsHmHEk5knx6Y2vkV6a/SH8FS6QcyH+PeDapTt+yxxC+IxQ7BGqjKrTm20CcbxGH0dozJJBOxhHh3xJvhzNK9oRpbX1HZY=
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com (2603:10b6:a03:454::18)
 by SJ0PR21MB2023.namprd21.prod.outlook.com (2603:10b6:a03:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.7; Wed, 28 May
 2025 20:29:09 +0000
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e]) by SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e%6]) with mapi id 15.20.8769.019; Wed, 28 May 2025
 20:29:08 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
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
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v5] net: mana: Add handler for
 hardware servicing events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v5] net: mana: Add handler for
 hardware servicing events
Thread-Index: AQHbyq+jBskktfMqLEKNwCpz1a2HObPmPiIAgAJKHSA=
Date: Wed, 28 May 2025 20:29:08 +0000
Message-ID:
 <SJ1PR21MB3432C170336100D5DC1EC2EECA67A@SJ1PR21MB3432.namprd21.prod.outlook.com>
References: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
 <ea6b8065-76e4-45c8-a51f-858abab4d639@redhat.com>
In-Reply-To: <ea6b8065-76e4-45c8-a51f-858abab4d639@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68cafe0e-301d-4b3d-8fb9-7792e2ad9996;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-28T20:26:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3432:EE_|SJ0PR21MB2023:EE_
x-ms-office365-filtering-correlation-id: 8cbb78ab-7ca1-4345-886e-08dd9e264cb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b25LNkVLQmkxK3VCd2tGME1LWVhyL1p1aENFZ0o2cmlKN3JJUG1mNWplN0Fu?=
 =?utf-8?B?UzFMMGIxSlByZmRRaEhVWEhFNEZQQ2lPYXFVUXZXb2xTbTcxd1ZQVlY3c1NB?=
 =?utf-8?B?VVowcERMdjJtQXcwV053aDY0dCs2NmJ4OFlyb29EZXFzSWF4bENPR3pXeWxJ?=
 =?utf-8?B?TEFKekE4UkxLUy9LM1FXNnZwRlM4WktYeVFOVWhFd1hWUEx3dklHejhTSzRQ?=
 =?utf-8?B?OUZWaGdxQy9FRDVHNXF0cjR0L0o5NnllUzN2NVdzdWJvSEFVaWRIUk1YaHZU?=
 =?utf-8?B?K0FsY3pLa2ZQVnlha2xxWldXZ0pIeWNwSStZZVE0U2I0cGlvamNjSWJBVVB2?=
 =?utf-8?B?Z0Y3UklaenRvWThRcFdXWDlTRGEwcE5wM1BESHo2ckN0MkIvaEw5QnlFUnNq?=
 =?utf-8?B?bFIrQ1ZNaFl4cGRKL0JYWng2MG1nMkFQdy80dEdEWnovU2pGVUUraHJxK0M1?=
 =?utf-8?B?cTJxVkhsU2FSbXBMR3RMSWh6NW5PaUdER1JnQ1NQNXZjanRZSTZ3QlRwbkpN?=
 =?utf-8?B?MmR0V1gwNytjYzlhT1hOeWlpRTkzQ1ZzK242N3gzN3BRT29NRk9IZ21qQit0?=
 =?utf-8?B?OThOc3BWQjl1UXpsSytFNll3RHUyeTQySTlCbzNpV0FBQjdONXhnQS9NZjBG?=
 =?utf-8?B?Q2xoYUZhdUhDeFNBVlMyTVo3VWovdmpOZ0Y4cnkrbVB2N0FmT2ZaUkluTGxx?=
 =?utf-8?B?L2F6TWNoOEVuL0RoRTR6TlJkOFRIci8yaG5xeThjdWJydTRjclF1c01OejV2?=
 =?utf-8?B?YWp6dk1VUkMyNjVmWFBlQjZPNmpJeDFTWThDaENmcVpVcjRtcWkvS0R6N2tj?=
 =?utf-8?B?cVYxSXFMcHNzU1F6VlJTYWlZaXMvcTZDN29NRndoekFFbEwxQUNZVFRtQ0ZP?=
 =?utf-8?B?UUl4c1JOSXdvNE93bHN6bXR6aEZFZk4yZWpjOVdtOFM4VDh0T3pXbEpsckdV?=
 =?utf-8?B?SzIvanp5eUphbTBpSTkrc0dRTCthWko4NXRna3lNd0tsenFhazlhbElnemJT?=
 =?utf-8?B?SU5NQjIxRzVVVVFrNmlDeFBiME5HNlMxMkRTNXZPYUVaZkVHTjRYR0VIRlhQ?=
 =?utf-8?B?ZjF3cXpOR2lSaEpNQU9PcVpUdEkxK2lyeXgvRWZWVU5JYlhsNjByNThqWjBs?=
 =?utf-8?B?ZlVKNDJhVGN5Qk9TVk5ldHg0TmRWUHlhNnlxWlVBR0g2azVobDQ3cHpqZSt3?=
 =?utf-8?B?UFhBRnUreWNvOGNraWdiOHNVME5jZ2s5SHZKRmVkdVQ0bk1QZjVxTmZrWmFP?=
 =?utf-8?B?MnhvWXpWeFVkNC8wY2YxUXI3NG9NOWxWS2VTcWtVcHArRE0vYlluY2VHb080?=
 =?utf-8?B?RTNkOGhDNGxqWlhmdmhlSXVIZXJQSXd3Wm5ROUxJbWlrK3dnSWcrazFycCtk?=
 =?utf-8?B?cWprWEo0cVcyWnN2Tm80bU5ndzdNdmR0YnZoc012U2psMGxTc0dPNjJrUWhE?=
 =?utf-8?B?V2tJNWRNNlhYNlBBbERabnI0WlJFTFFRb2NsNlpiZHNOWVBxVVRERHd2RHFi?=
 =?utf-8?B?dmZsSk1YaFFoUEd5cEYwbHBaQ3NMZUthaXk0K3MvWWp0M0I3dktMQ252ZVZh?=
 =?utf-8?B?WStpbjBKZVNXYzBSdDhuZCt5UlM3WlYza3Z0alBFZmh6UzcyWVE1WVhxNjcz?=
 =?utf-8?B?R3JvQk9yWGI3VDdObXc3MVNleW1mLzdGWU9RMUpqQ2NzUitKeHQ0RUx4WDVT?=
 =?utf-8?B?N2JlRjhsVE5NNkNQd000RzR2SmVEeUU0aTh4djFMZzFFa0dnR3BxSXlSbURG?=
 =?utf-8?B?QlQwdGNBbmlhZ2FKaGFDK1RaWEJJNm1jWmQxZ0U2RVlYbmtaS09OcGZ1aU9K?=
 =?utf-8?B?dm9aMmJNV1AvSHFtcW5xMUZqWS9BZTV6akNuN2xZU0NSTURsbmxuSFpSY1da?=
 =?utf-8?B?M3g3MUppUUw1aXUxOUVsVHJiQ01sanJIMXdaQkVRRnFSSXcvMFhGSll6RjVZ?=
 =?utf-8?B?WGs0NHRIeU1EeGRSYmdFYUtabWJVVTUvUVpWOXdiWkZhZ29SeVl3ZTRFOFJF?=
 =?utf-8?Q?b6I+aH0mX6jIoilTH8JqqJwR4l674M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3432.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGlqT01YZWpDb0VVTUQ2UHV0L0gyelE4L0RHMTFjZnhQdW51YmJxQU4vQ0dv?=
 =?utf-8?B?ZkdUU1JNQitUYTV0SlJXbzNOOW8vL0c1TUl3ZXNSMlVJVnIvak90UXQycnFM?=
 =?utf-8?B?eTJhVW9UZm05enJJNGlQa2JIbEpRK3VKMmpudDVvRXAzNmJXVnJXVjZ1ck9s?=
 =?utf-8?B?UmkwREJkSWNaaFVaRzF4MXhKSXJuejk3Z3JXM2ozMmswalNsOVc2elNnZll6?=
 =?utf-8?B?bUtvOGRzTWlLOVRhU29ZVEc0cWNKb0JvSFhvd0h1ZENXblVQaldJdm0vRERy?=
 =?utf-8?B?NnNqS3B4MGlvWHdpUEZFUHZmWTYzcUhlZnNIUlMwL3ZNVDFVdDYxUDBHUGl2?=
 =?utf-8?B?RUR6TFVHT2MvWkhwUHg1YkJ1RWNKV3FMWm5BaGJkbnJOWkZ1LzRlUEhmMm81?=
 =?utf-8?B?YXlpc0xoSjVVNnc2Rk5BQ3ovREF0Zzh5MSt0Y1hodTZIWW83b2xybEFxaE9h?=
 =?utf-8?B?cGUyWFNPYURlK1c1ZGMrbUpwQUJ6blF3UHI1SG82R2tiU0RpbEJPemtpTmsr?=
 =?utf-8?B?ODRLU2UyVU5EZmx0OVErclJsWGduYU1ZUXB3a2lnbjdyN0MwQ2FRZ2V2Y2tx?=
 =?utf-8?B?Q3NzWC9VOERiaXI4WTlqT2RTaGZyZXN4WkpmWENNRldBSHhwU09FSURocVdy?=
 =?utf-8?B?L1kyWC9TN09lVUtJL2gxL2ROL0s1QmRIdjA0TUEyMnhoeG5xYlNqK1ZsTWp3?=
 =?utf-8?B?VzU3MFpXbFBlYWZsVU9BczFUT2l3ZklWTnBycGJTVjJQa3lxblJWUm9ObmRO?=
 =?utf-8?B?VjJEanRvaFdCeVJwcTRXWlp3WnJrdmRBY3dCS21IV3NwdTZFODNuRnJxQmJG?=
 =?utf-8?B?cHN6MHZxRC84bXRpQXd5SGtscW9NOVFCcmZYendtc0k4R3FRNWs3RjR5TnU1?=
 =?utf-8?B?RVhVVjYyUjVZeUVQNy9wbUJacUxFQUxLS0Nhd1VmRGJ0RFdKblRUOHhwOW1j?=
 =?utf-8?B?RVZueVorRGlGNTBHVTgvN08xdTErOVZnQktaQldVS1g3WHZJR29BeStuNTdq?=
 =?utf-8?B?TDNJZHZQVTJwdDYwckpYb2k1cmlVa0ttdVd1Z2N6dzBVWFJRM2FvbUE1TEhR?=
 =?utf-8?B?U2hqQTA2MXEzOS9PK0U1c3FyUm9XeHZsQlBWa1FhSlBsVm0wdU9tWUdwQzVs?=
 =?utf-8?B?MERhZ2dBNDhGSTBzTEtnWThaalU3eDRCOUJady9tSzFJa3Y0UG5HQ0ZzenYy?=
 =?utf-8?B?YWpsWkppeGxRWUR5L3QvM3ZnQmRmY3RETkpNZzl5YUFOT0VTWStTRGlrSnJp?=
 =?utf-8?B?cU1ZOVVvaERzeU5ycmJvUGhSTWtuMVFwamFoR21QcFBDbElobWY0aGJsV3hX?=
 =?utf-8?B?YWo2Yk9Ycy9KSW1naVBPYWFsSWdkUDhBMXlrSEVLTWpzVDJEUjNkVmFrMDhk?=
 =?utf-8?B?Tk1ScTF3ZDJxSTJtaStJTXZ2dDBaUkVVRWd1eGhtVG5DM2xobi9wWEhYMFdH?=
 =?utf-8?B?ZHRRUkZJR1hWaTdyTElGOHcraGoxbGNqVUdzU29kZllYV2VKZTB2d05icUZE?=
 =?utf-8?B?MmFhRFY0bmlidUZoRUg3dWxqSENpOHlmODVtSC9FUVU1RGxnajg0eFJmaWo0?=
 =?utf-8?B?a1M0bmtVZXJDRWFoTnNUYmxiVUVIQ3duWjkrN01TbmttMnoyc0VwUVhNYVpz?=
 =?utf-8?B?QTAvMklTRUI2RjJlVlRsaUFXNDYzMXk4bzNqRjJKdzBKeDA4bTF0SzN5NGZ5?=
 =?utf-8?B?bjVIaFJ5Qzdtd3UrRy9BVnBtM0VjOGhhQzJlMVlQNWJFa1c4WlNIOHpmODU3?=
 =?utf-8?B?amNtNTMwa1lqaXdUL0VibjZURUpNcUtsVXVXTFZMN01KeHpscmN2STk2TzRa?=
 =?utf-8?B?U3ArUjdKU2FZRmNYdHdUNkhyQi9jR0FJNmtFL3MyL1lOcW5vdEROTVNGeXY1?=
 =?utf-8?B?UWI5aXBVaFl2TzJySjFJVXlJSkdTcWpJVEdGTDR5cXRkMG1rSHg2bWlJbVUr?=
 =?utf-8?B?eENKZDNzczlOd212S3RCSWFlaDVoRUNMSnBIMGdUQmN0d055emM3SFNyZHZI?=
 =?utf-8?B?Tzh6enpnY0hwL3AzT3VUd0JadWZRUlk3QzVBZ1ozeWlscGVHWWNwY2tIOU9w?=
 =?utf-8?B?V1JvcmlwL0QzWk5NMkpQVTFrb0p3Mzc5Z2xHeWhxVWdoc2RDZjNUYjAzSTFh?=
 =?utf-8?Q?A1CPZ4FCzmXbYGXQdFLiPhi2x?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3432.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbb78ab-7ca1-4345-886e-08dd9e264cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 20:29:08.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmSW5cmjl5YRUMKZzfxKY0Iib9TqBEN7k2PQzfqOYWoSsVkaMIvNll38olT4Lza/cjlAYD3kmtJYhtDk5hX9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2023

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjcsIDIwMjUgNToyOSBBTQ0K
PiBUbzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWh5cGVy
dkB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IERleHVh
biBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsg
S1kNCj4gU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+OyBQYXVsIFJvc3N3dXJtIDxwYXVs
cm9zQG1pY3Jvc29mdC5jb20+Ow0KPiBvbGFmQGFlcGZsZS5kZTsgdmt1em5ldHNAcmVkaGF0LmNv
bTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gd2VpLmxpdUBrZXJuZWwub3JnOyBlZHVtYXpldEBn
b29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IGxlb25Aa2VybmVsLm9yZzsNCj4gTG9uZyBMaSA8
bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb207IGxpbnV4
LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGpvaG4uZmFz
dGFiZW5kQGdtYWlsLmNvbTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgYXN0QGtlcm5lbC5vcmc7
IGhhd2tAa2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBzaHJhZGhhZ3VwdGFAbGlu
dXgubWljcm9zb2Z0LmNvbTsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBLb25zdGFudGluDQo+IFRh
cmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPjsgaG9ybXNAa2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BB
VENIIG5ldC1uZXh0LHY1XSBuZXQ6IG1hbmE6IEFkZCBoYW5kbGVyIGZvcg0KPiBoYXJkd2FyZSBz
ZXJ2aWNpbmcgZXZlbnRzDQo+IA0KPiBPbiA1LzIyLzI1IDI6MjIgQU0sIEhhaXlhbmcgWmhhbmcg
d3JvdGU6DQo+ID4gQEAgLTQwMCw2ICs0NDgsMzMgQEAgc3RhdGljIHZvaWQgbWFuYV9nZF9wcm9j
ZXNzX2VxZShzdHJ1Y3QgZ2RtYV9xdWV1ZQ0KPiAqZXEpDQo+ID4gIAkJZXEtPmVxLmNhbGxiYWNr
KGVxLT5lcS5jb250ZXh0LCBlcSwgJmV2ZW50KTsNCj4gPiAgCQlicmVhazsNCj4gPg0KPiA+ICsJ
Y2FzZSBHRE1BX0VRRV9IV0NfRlBHQV9SRUNPTkZJRzoNCj4gPiArCQlkZXZfaW5mbyhnYy0+ZGV2
LCAiUmVjdiBNQU5BIHNlcnZpY2UgdHlwZTolZFxuIiwgdHlwZSk7DQo+ID4gKw0KPiA+ICsJCWlm
IChnYy0+aW5fc2VydmljZSkgew0KPiA+ICsJCQlkZXZfaW5mbyhnYy0+ZGV2LCAiQWxyZWFkeSBp
biBzZXJ2aWNlXG4iKTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlp
ZiAoIXRyeV9tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKSkgew0KPiA+ICsJCQlkZXZfaW5mbyhnYy0+
ZGV2LCAiTW9kdWxlIGlzIHVubG9hZGluZ1xuIik7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0N
Cj4gPiArDQo+ID4gKwkJbW5zX3drID0ga3phbGxvYyhzaXplb2YoKm1uc193ayksIEdGUF9BVE9N
SUMpOw0KPiA+ICsJCWlmICghbW5zX3drKSB7DQo+ID4gKwkJCW1vZHVsZV9wdXQoVEhJU19NT0RV
TEUpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWRldl9pbmZvKGdj
LT5kZXYsICJTdGFydCBNQU5BIHNlcnZpY2UgdHlwZTolZFxuIiwgdHlwZSk7DQo+ID4gKwkJZ2Mt
PmluX3NlcnZpY2UgPSB0cnVlOw0KPiA+ICsJCW1uc193ay0+cGRldiA9IHRvX3BjaV9kZXYoZ2Mt
PmRldik7DQo+ID4gKwkJcGNpX2Rldl9nZXQobW5zX3drLT5wZGV2KTsNCj4gDQo+IEFjcXVpcmlu
ZyBib3RoIHRoZSBkZXZpY2UgYW5kIHRoZSBtb2R1bGUgcmVmZXJlbmNlIGlzIGNvbmZ1c2luZyBh
bmQNCj4gbGlrZWx5IHVubmVjZXNzYXJ5LiBwY2lfZGV2X2dldCgpIHNob3VsZCBzdWZmaWNlLg0K
PiANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIHVwZGF0ZWQgdGhlIHBhdGNoIGFjY29yZGlu
Z2x5LCBhbmQgc3VibWl0dGVkDQp2NiB5ZXN0ZXJkYXkuDQoNClRoYW5rcywNCi0gSGFpeWFuZw0K

