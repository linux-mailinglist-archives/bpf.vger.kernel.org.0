Return-Path: <bpf+bounces-26690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA08A3908
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 02:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F91A284409
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9C647;
	Sat, 13 Apr 2024 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b="o0WGcqgA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F658163;
	Sat, 13 Apr 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712966724; cv=fail; b=QWLqr5PQD1iZTyQqAd+xzdi/mdKGTj9dngtZwbwtPZgMDYCIaX8d5ni2c6wxk0255jeEodBsYJlsAu/rBpJeG1fx9/78inUDMifXWtoWQoutyxFScyfB/LHoVR5D83bMZTUEpG5ajJrOVdHZzCed9ph5VzsOvHrdjxxBp3nw2UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712966724; c=relaxed/simple;
	bh=hHDiC8PA9NCy46eJkp4N3bYm5/7HFF1S/2Wy8mnQySA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bwe9Wpdqz8HCSeX2CJesI8YvgwCH8AL1achWDNnYJWf/a0UMuz+rYcS6ym3W/29/UByTuI8VoIsgS+BjpZ4Lzo0mu2o8YAPyIqxhrzTuF4vBvmEFu6RUpqextJIG1NbgRUTK7qC0lnhn3o2B+/tE6vsndQi0qmuvk8ybkZlzNP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu; spf=none smtp.mailfrom=cs.rutgers.edu; dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b=o0WGcqgA; arc=fail smtp.client-ip=40.107.220.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cs.rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3tVW/D7qqtmG5gQbBtElfPRPMK6zddt4rTYghB8W2dDEKuT7/T3Di5NsbyZkkswwjnkHFyiuVEzWRa2VsCM6lFVP/TrYqIE11/QGhJmKx9jpeZw9Sw0ThhDJ8ARbnL3bUH56jH3WqqiIsdRFOWSlwwdDaECY+tfMMxpJBctFdVLLk+f+tW2GxTK4OPdOpDASp3jkjsZpW+oD9qnuZzIlNadyRUnyyB2PiqoVvIdGqxtOpc+g0xFlMAhzFG8dJ5IxSVk6AS9hStWn5yqhULoy7CcEk9mOh6orXPxTLcnEO1Md6Yxqzn0yaUdrW3qJPlySKYZx3p3sTUWVrUsARL9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHDiC8PA9NCy46eJkp4N3bYm5/7HFF1S/2Wy8mnQySA=;
 b=HKOKRwfDuoionnPyt+Mf1YfL7LORbSHszJsKQvtykUk7NRDeJmKoi8xnyRi6RvBn7R82+w+t/wgoPdZfH4pY44sM2CBgWgOaYbsv5s2zTZ66R/22+dAYOwVkEjvQQTL9CesBuZ0+DgEe2iXhWxSfqQGZW35/7DcpGyqoKWq6k7nCWXQue+FwcblT3JVDJaomPpdMXmGUUCRf/fa7OuPTr4O7q8uyuFY2gMgjzhYb49Dp204AIazDiT4hwDStghvb9EjXuSw8pPMmAvL3qz6al9QtdJEX7xVRH4ODl9pRd04wWe0ZNfj0kOVQSCjUWw/ynMhKgroj6okbrQqcVytDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.rutgers.edu; dmarc=pass action=none
 header.from=cs.rutgers.edu; dkim=pass header.d=cs.rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHDiC8PA9NCy46eJkp4N3bYm5/7HFF1S/2Wy8mnQySA=;
 b=o0WGcqgAX73Mw/E483bKly/xeVcuMYW5NipkFr4/a+KAwLaGpSYYJixoOQubpOc1jal6/WLJNAy23CxCTbFlavvNwXs1H5YRaF7EGNpBrJjAIRDxADCeXt5JcoIxwBTGRiEf8SUW4IF/ZkGfJsadYzO15WVqKAKgPZn9Op8N24tqFmwOWNpYdx57k+2og/cfEDGkPnoR9pE9pP8cAo3zXjbzPHnO5R63IpVEEoR6gPEe9Doz/P5L0A7UCnamwVMgCE8ldnktYFWVGUUki9ND65Dpo6HAw2ITU5ATT5ayLTu8jQtkwEcmM4j1nY7wws+9+W3mK6sjMvAW7ez6mpSywg==
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by CO6PR14MB4228.namprd14.prod.outlook.com (2603:10b6:5:347::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 00:05:18 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a%5]) with mapi id 15.20.7409.053; Sat, 13 Apr 2024
 00:05:18 +0000
From: Harishankar Vishwanathan <hv90@cs.rutgers.edu>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, Harishankar Vishwanathan
	<harishankar.vishwanathan@gmail.com>, Edward Cree <ecree@amd.com>,
	"ast@kernel.org" <ast@kernel.org>, Harishankar Vishwanathan
	<harishankar.vishwanathan@rutgers.edu>, "paul@isovalent.com"
	<paul@isovalent.com>, Matan Shachnai <m.shachnai@rutgers.edu>, Srinivas
 Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
	<santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Thread-Topic: [PATCH v2 bpf-next] bpf: Fix latent unsoundness in and/or/xor
 value tracking
Thread-Index: AQHahUPiguRDmdZPfEqf6sGDEny2aLFWilQAgADeBoCACNCbgIABNTQAgAPzzAA=
Date: Sat, 13 Apr 2024 00:05:18 +0000
Message-ID: <C11E783B-50EB-40F4-A3CB-F9ED5B909B9B@cs.rutgers.edu>
References: <20240402212039.51815-1-harishankar.vishwanathan@gmail.com>
 <77f5c5ed-881e-c9a8-cfdb-200c322fb55d@amd.com>
 <CAM=Ch04xd5u75UFeQwVrzP7=A5KPAw3x7_drqQHK3C-43T4T2w@mail.gmail.com>
 <9d149d61-239c-67ac-0647-b59a12264299@gmail.com>
 <ogoballkzys66cu5mt22krntaswkau5bpnu7efs5x6uw7jdvng@drdai5ecq7d5>
In-Reply-To: <ogoballkzys66cu5mt22krntaswkau5bpnu7efs5x6uw7jdvng@drdai5ecq7d5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs.rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|CO6PR14MB4228:EE_
x-ms-office365-filtering-correlation-id: 64d443e7-e80b-445e-6945-08dc5b4d6754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IXcwDocGAx5xIgNpQDWiCl1SGGGlZPq9I7ylhRBZs8bqk2nfAFj5eMPWF1RyjYYHy0Semz7IyLP+wG8XQL+cJdwKdGOJM/UmZ3NfoHUZ2vVHKDSp3DzBI7bVdUBXx2bBGAQUArxnB2uqE93id41SxiYR95tBYDMZwFls/Dxp5x3HpwRh+/5+fqR5qv9x0IukGeH6rPypzPZJkvOHHuKKvgbEFBBvvvW1Qkees4zaij7TlxQGWEknW6na43xF4Qr4kccz/C9fpMqiPFE/LyZ4QMYyS4ot3Js1C8ojmdBSZb89a40hsIe6ESuosCr7x+TVpPo/HbLAs0pFom2SFlgIrCIGaMJVvItpyM7wdggfYeQ7x6SXOJaFGep4ihdF6O8uVBZQ51twcE/mB+pUGuuqv8IcnWjGoUuhACfNG5OvLXrZ/r++xbiRwmWwoXYaoau/jnKNnh1ZSKq2qVuDmfyKAxJqzvZA6c1HpNRPI9CvMLH4oyAjBNjtGovLDmXUgifcFU5Z7NOOug22+ewFSw+NGIf6gR4msUhtNBBF1py9DAvi/SVTKUm2gxj9HHMsxp3D4nUxE9a0SCvbj7rSnp1wIF5RUnbjGS3dHjsaUPGgQOd63WmgXa4yq+01sR5gLDutLyq6/KONJa4aZ8g9ienOTFUP6lYRutbtYEofFERAwQ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MENPWXlxMU83M0s0N1NTL3BNS2VOMUd5MUVyd1h3SEUyZmVQLzhsWGhuR294?=
 =?utf-8?B?Ukl6NHIzT2tBRXQ5WEh1MFhFQXNwamR5TG1zSUI5U2V5UkxyaGRZY1V3SjUx?=
 =?utf-8?B?cDRpSHdGeVJENm8wcG4wVUMzM3dxb3JKRDN5YjFLWU82Z0VTL1dSc2M5YkVa?=
 =?utf-8?B?eit6WGRxWDZRME5kdDZHMTZ1NkVUZDhEOVJseDZYdWF0ZlFpZzRDWTBIU1Bz?=
 =?utf-8?B?THVMeG9GZzZMSmpad1RCbGRyeTF4MzNCRjVudGNnTnRhaUt4VkJ2ckZMVTg0?=
 =?utf-8?B?TzlTd3pPLzdPVkJ5RzN5YUM1bDlESkJkZUNGVUZzRnpoWnVJaUZ4enVQRkVX?=
 =?utf-8?B?eDdWTFpTU1FoSmdFN3hlZmdDMkhINmJUM0F5QytlUGtEMmhTWDhnRlZUR1h0?=
 =?utf-8?B?SFppQk5zR0xiVFZXZUNmYTBvZ1VyclJXdlNuRVhMb2lKZ20xdlRnNlV2d0FW?=
 =?utf-8?B?V0R4SlY2NXVWUGZsZ2Q5YkxHWGdoNVlKT1ZNRUdXek9MQ0tYbDFibEdhenFD?=
 =?utf-8?B?T0tqUm11TDJOejRRNVR6d1NzdUR0eVJGSWNkY0xtbDBTY2Q2K2JjQ2ZtUlBa?=
 =?utf-8?B?TGVBdFVhYkVOV0Fqb29yVm40WEJqNklkRkFWdFVPbzFyRVZieTJvaVdsUTBj?=
 =?utf-8?B?WFVxb0txNGU3bnpkSTJ4SW1pcVhhemtROUkzZGhkbzNEclczRSsxdnZxeTRv?=
 =?utf-8?B?NXNmZFJuMDkwU21UQXByM3ZCa1dhUC9UUCtGaVEyYzYrS2p6WlhVcjc3U3Jl?=
 =?utf-8?B?RVlGRldTYjZrUkcxT2d1VWw5QW9xTmNiaCtKOWFYRGlkSkdTT3Jja2pzMUdG?=
 =?utf-8?B?VHh5SUpSNkVySTNBZ1JIMUs5VE1qRTMyMS8ycFpqb254RVVsOGJ1K25NYXB2?=
 =?utf-8?B?amF3MXJVeFJoVW5TN3RNQU1wSkZZVkx1eVVXeVBYdHdNWlpTQ3o0a1ViMEIz?=
 =?utf-8?B?ZFJHMVdpdFpmNUpLaHJXTWMwUHJsQ0o2NHVzc0NXS2NPcXZIZFNNQ0U3Smxu?=
 =?utf-8?B?Tm1NdFQ2bXdQbFIrTVE0SXpVSU12UnFNQXRvbkdOMjlka0JrN2VHTXpyQnB2?=
 =?utf-8?B?TWxoR2NzMHFBRHYxVEFPOWpxTnByb0VNS1RaMWp2SmpoNzdqSHg5bVRGR2xJ?=
 =?utf-8?B?L1Jkc1BjWDdtbFAzd0VBZm1xcC9WT2tKVTNOd3l0dHNYejVFZHluNm1aZzZE?=
 =?utf-8?B?ZXlKSFFBSnhZQ3pMcGZGdk5odTFEemlSTGUxaFRsUE1NZDFxSU9SUVZEQkh0?=
 =?utf-8?B?VkZqaEJSYzBLTVh6aUFXQllHN1VldksvaWNYWDQyK2F6a3ZqM29lM1RnQlJn?=
 =?utf-8?B?cmw0Wnp6TWgrUTZURUk3YlFhYUdpWHUwdk0rSmdQWktWSkpXbGFPU3BHNngw?=
 =?utf-8?B?cWwyeUplbWlQdlk0ekVMdU5FQjZDYnpRUzdLUGErTnVGNXRlb2JOVU93dldi?=
 =?utf-8?B?RmhRVURTbWo5RE1qaXJTazh2NVBtc2c2amU0THh5VFF1OVdQN2xkbE9tUklK?=
 =?utf-8?B?dUR6VFMrTktKbVhiQkVRYTVLNktzekw0QVlSSm1JVTlJbXdVSzR2S2dJUkdY?=
 =?utf-8?B?Tld3dGwybU9SZFlxOWNJUi9kVDVkR3pOeHF6aHB3Z1VyNkV1N1ZTUnpXZ1dD?=
 =?utf-8?B?dzJYTHN4SUJ4NkJQSGxSak1ITnpnWGRETzliTC9zekJjOGNoci9TVnVtVHo2?=
 =?utf-8?B?VnRCL2djV1g5amJqT0U4OWEvem8vK1kvM24yOVRxaTVYVW5FN2RWeHMzdXJo?=
 =?utf-8?B?VHNGNmhYVThsaDV3U2tXejZNaWpvYnhsN3Zyb0JvcVhqRlhDU29oY3dQRXpY?=
 =?utf-8?B?YXlTYjZXekY5bmkydDA0b3ZYTGNGbXI1bjlXZ0ppZStUcmQ4bWQwVzBZS1R4?=
 =?utf-8?B?RWFHWklneXllOGo0cFdmaFpnem5YKzdIU004K1cyTEdjaThmSTJ4VEg5VjRs?=
 =?utf-8?B?WFg2K3M3OGxwNHJpcENzQ05FUDBtd1R3dm5zZnZYZXZhTk9Ec0lqYmExLzh5?=
 =?utf-8?B?NldOVk5qRHo1RWFCVGoza214Uzd0cElLMEswdkZKUzgveUpNZER1SGw3Zi9Q?=
 =?utf-8?B?L0VZdlZMMzl5Vks0czFPZE1TbkgwN0pqVzNoV2IyWStQeVdCdmw3OXoySkNK?=
 =?utf-8?Q?OwFfGDG1JSdthWrlswluu1gbF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB626CB7604C524599A520BA0C2C6195@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR14MB6501.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d443e7-e80b-445e-6945-08dc5b4d6754
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 00:05:18.3555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xFCtVnWjd62WmrU6mCtZOQFqa/rdN6c+pcXfrt/VOYi3UQLCsqIBgY6fgZmOcUAxxfGp/xtYm6Pko5Jtf4aog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR14MB4228

DQoNCj4gT24gQXByIDEwLCAyMDI0LCBhdCA3OjQz4oCvQU0sIFNodW5nLUhzaSBZdSA8c2h1bmct
aHNpLnl1QHN1c2UuY29tPiB3cm90ZToNCj4NCj4gT24gVHVlLCBBcHIgMDksIDIwMjQgYXQgMDY6
MTc6MDVQTSArMDEwMCwgRWR3YXJkIENyZWUgd3JvdGU6DQo+PiBJIGRvbid0IGZlZWwgdG9vIHN0
cm9uZ2x5IGFib3V0IGl0LCBhbmQgaWYgeW91IG9yIFNodW5nLUhzaSBzdGlsbA0KPj4gdGhpbmss
IG9uIHJlZmxlY3Rpb24sIHRoYXQgYmFja3BvcnRpbmcgaXMgZGVzaXJhYmxlLCB0aGVuIGdvIGFo
ZWFkDQo+PiBhbmQga2VlcCB0aGUgRml4ZXM6IHRhZy4NCj4+IEJ1dCBtYXliZSB0d2VhayB0aGUg
ZGVzY3JpcHRpb24gc28gc29tZW9uZSBkb2Vzbid0IHNlZSAibGF0ZW50DQo+PiB1bnNvdW5kbmVz
cyIgYW5kIHRoaW5rIHRoZXkgbmVlZCB0byBDVkUgYW5kIHJ1c2ggdGhpcyBwYXRjaCBvdXQgYXMN
Cj4+IGEgc2VjdXJpdHkgdGhpbmc7IGl0J3MgbW9yZSBsaWtlIGhhcmRlbmluZy4gICpzaHJ1ZyoN
Cj4NCj4gVW5mb3J0dW5hdGVseSB3aXRoIExpbnV4IEtlcm5lbCdzIGN1cnJlbnQgYXBwcm9hY2gg
YXMgYSBDVkUgTnVtYmVyaW5nDQo+IEF1dGhvcml0eSBJIGRvbid0IHRoaW5rIHRoaXMgY2FuIGJl
IGF2b2lkZWQuIFBhdGNoZXMgd2l0aCBmaXhlcyB0YWcgd2lsbA0KPiBhbG1vc3QgY2VydGFpbmx5
IGdldCBhIENWRSBudW1iZXIgYXNzaWduZWQgKGUuZy4gQ1ZFLTIwMjQtMjY2MjRbMV1bMl0pLA0K
PiBhbmQgd2UgY2FuIG9ubHkgZGlzcHV0ZVszXSBhZnRlciBzdWNoIGFzc2lnbm1lbnQgaGFwcGVu
ZCBmb3IgdGhlIENWRSB0bw0KPiBiZSByZWplY3RlZC4NCg0KSXQgc2VlbXMgdGhlIGJlc3Qgb3B0
aW9uIGlzIHRvIENDIHRoZSBwYXRjaCB0byBzdGFibGVAdmdlci5rZXJuZWwub3JnIChzbw0KdGhh
dCBpdCB3aWxsIGJlIGJhY2twb3J0ZWQpLCBhbmQgbm90IGFkZCB0aGUgZml4ZXMgdGFnIChzbyB0
aGF0IG5vIENWRSB3aWxsDQpiZSBhc3NpZ25lZCkuIERvZXMgdGhpcyBzZWVtIHJlYXNvbmFibGU/
IElmIHllcywgSeKAmWxsIHByb2NlZWQgd2l0aCB2My4NCkknbGwgYWxzbyBtZW50aW9uIHRoYXQg
dGhpcyBpcyBhIGhhcmRlbmluZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCkhhcmkNCg0KPg0K
PiBTaHVuZy1Ic2kNCj4NCj4gMTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3ZlLWFu
bm91bmNlLzIwMjQwMzA2NDgtQ1ZFLTIwMjQtMjY2MjQtMzAzMkBncmVna2gvDQo+IDI6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN2ZS1hbm5vdW5jZS8yMDI0MDMyNzQ3LVJFSkVDVEVE
LWYyY2ZAZ3JlZ2toLw0KPiAzOiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2N2ZS5o
dG1sI2Rpc3B1dGVzLW9mLWFzc2lnbmVkLWN2ZXMNCg0K

