Return-Path: <bpf+bounces-34221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C492B4A5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F40285CC5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E1155CB0;
	Tue,  9 Jul 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="V7hcRy0a"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3C12E1F1;
	Tue,  9 Jul 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519424; cv=fail; b=aL/VroWE9i3GF05z7Oe2WRzMDdpoLDoi9ZGz+Q9A/9sfdvwci/uTvJPNI8ygfVcPUMGwAYpIHXzOT05wSHUmni5lVpoQ21qnRvC9zH5lwyt6yUKsVab7bInRYIHiMY+ehG4QkQKJ1sD+yxe0m78GW3wNWCp1am7l5Ar9NEs2u4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519424; c=relaxed/simple;
	bh=aCy53+1mv+kZeeXXCTobLdhXbbdBXYjLGAJ3krOlBe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iQi1LxpcKX/0n5L6+U9sBM/pjHW4puDYnNwNj+PxFipAL+TnL2jsiFmuqdEeXCS37qO8GAVd1BSMwAd4tYKqaWfHjgXvdWQiwZsL7VCEGabw3E08FumY8Il77ZvA8JtaKsK6+rRibmTDbDVd/+o/VeTpviFzbbw1qLPEnfkRCdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=V7hcRy0a; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/+f2l17wATbRFlgy/4H5URNjHAUXtxvo6sstWOR4Mrswwx2UT8m++K21ZY6bbaF5RR3IYelUyIT4v097QIU3t/vSK2qshxUgKE3lQvdxuKYBkhnkvQfSoYLqK8Uum6N618+PVQ72Mdb0aiaQW/YuhUklaChNaD382w24h33lyGuyEA5DDyhrQvPgWyNanPna3dyAZ6yaW2I5qhcsx8DKV2MKEnYt05ooDcmeXC81aTY6r2WozGT+tRNlEUdicg+wP+txKo3FR3b79pR3ocfF12qoJAphBPZpjcEO8KP555bjtydtx9xX97kO+72H4uXc9Ix2UW/a38FbMLQSz2c3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCy53+1mv+kZeeXXCTobLdhXbbdBXYjLGAJ3krOlBe4=;
 b=Wxk0w2uJzr0ymJ4DdxX+IrlnNwzV2zLKulDC1bMMoFff2sqxo0aPYZ/TTlFJglCfJdOvm6Z/npc4QCaLRvlh/QZwk1/6lpZdE+hc9uz6rn5i+fObOlo7wuPfeiBng7cNwMZTgjvVmpnkAQnht98+ha5Ny0Y+4BkCDZmJJqBEiT+P/+SZwaPaqQ9aGhFfKfxpl5XJF5W7snqRRI9jIe/D3K6BRZVagb5hJNdCrfn57FNg4oRYcQ8QTmDChomnBZu5j5/jGcuFxnuOMltcn9JJF3/9VT/GN73EiyjIhJ+oMY3J+MBmPqiy4PSwy8Qa2tkBN5pgIpCsstFcCOZkU6avJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCy53+1mv+kZeeXXCTobLdhXbbdBXYjLGAJ3krOlBe4=;
 b=V7hcRy0alkD94PGhE/tvnx/NHXNWYityj4RhOE+ibjKRAng9w5U1BcicWujfvmUtzQd0OwSqPBVuamSC9CVTrJIKNt6HUJ+FafMQjOLEMDz48K5B1Dv2fDLhPiIlwtspGEHWVuyCCC3b1C4kLCj4znbX+IcltRIWuIzj0sm5/Lx6gj6zAn8DhrgGHg9ZRbTfhcVlw+bqW2MCqac98UE2f8FmXs6e5vRaWtj7My3c0p0GBIBEhlfmZMHaEjeu5LAHDQRQV2xdcQ6tk5jZ7Wkiot9vgeYSs7uTDMe/42KPTcicJk53+14qlQEHzmF4w+GyRtyArAS5WfipPOBre18O8A==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by PAVPR07MB9239.eurprd07.prod.outlook.com (2603:10a6:102:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 10:03:37 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 10:03:37 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: WangYuli <wangyuli@uniontech.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "song@kernel.org" <song@kernel.org>,
	"puranjay12@gmail.com" <puranjay12@gmail.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "illusionist.neo@gmail.com"
	<illusionist.neo@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
Thread-Index:
 AQHaz1JvmhkZvbTHdkOR2W9HlG+2VbHpb4AAgAFx/oCAAebSgIAAK6gAgAEumYCAAAJ+AIAABDMAgAAGoAA=
Date: Tue, 9 Jul 2024 10:03:37 +0000
Message-ID: <23b480a7-fc50-44a9-b6f7-9d112059e7c3@cs-soprasteria.com>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
 <2024070815-udder-charging-7f75@gregkh>
 <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>
 <2024070908-glade-granny-1137@gregkh>
 <4d07cfa3-031c-45f4-aec1-9f0a54dd22b2@cs-soprasteria.com>
 <2024070953-sepia-protozoan-86a0@gregkh>
In-Reply-To: <2024070953-sepia-protozoan-86a0@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|PAVPR07MB9239:EE_
x-ms-office365-filtering-correlation-id: d7c8a019-1802-4e7f-9118-08dc9ffe66f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWRkb2ZjVlpNSTZlZGlSQW0zam9HZ0c3eXBrYmh5eXlVRHpYdm10ajh3TVQ3?=
 =?utf-8?B?SzNZQitKZEZCNWY3ODIyM1IyMmJzTTJnNGtQNWxzWjFqME0vTUgyekJISGxz?=
 =?utf-8?B?YjRlSzhKR2w5UXdMMmJha1ZxNmhCL0pPZm0xM2tMY1I1d2VKeDYzODl1aUtL?=
 =?utf-8?B?ZVdPVTJ0T0g5NVoxNXhDU25yMEpScHBWVXo2Vk1yOVVuUDRhcWtDWGV4WUd4?=
 =?utf-8?B?R3FyaVQ1Qnc2dER0MGRibXlKSzFzalIxSWtWSFFHd3dXdkJWYVRuZFlnTS92?=
 =?utf-8?B?UU0xRFhKQWFQNW9vSkp1K2NHSEdwaXRyaDRJWVY1K0tHd1pnVmJqTlFrVm1O?=
 =?utf-8?B?MDM1RTM3ZW5ZRmRsZ1JkckRaRlp4WFJJMDlEeWFVMEl2STBjNDlLV1dZNFN1?=
 =?utf-8?B?Rk0vL1dtMjVxaGF6SDFueE1nU291cFZBUnRqSlhuKzY1NzJMT1pLNGprb3Uy?=
 =?utf-8?B?eng2UDQ2TWJLWk8rOUpnc0RPQ1Z0c0ZPOXVFbkMvR0t1NUZ3UU9RWjVERGpv?=
 =?utf-8?B?N3RtZEdOcE5SVVRSb21hVW9IcmVzTk1zV0ZTMVhzS1dIWitGbmkyU0ZPbUpv?=
 =?utf-8?B?UitudnZoUjJzSnhML2RYZkVmbXNPNjFrQ2xYQ1pSSE15N0ZmNWluRjRsRmtw?=
 =?utf-8?B?MlhuMURsaS9QVDB4VTJnSDhKemRHcVd4dTB1V1dJYUUwWEEvRzBuQTJHZmhv?=
 =?utf-8?B?TEM2R0dpWHRlMjNQc1lJb28yNWZwRFdVc0lxamoxdUNkVW5yT0JTb2VXczFE?=
 =?utf-8?B?TmNYaUZGUGZMRTk0MSt1N2FyVUMvRllnZFEvSWVrMWg0VVJzb1d2YVdNQlRQ?=
 =?utf-8?B?VERKWmwwazREcVdNSUtxaHRmTjdlZ0FuOWY4UjlCZ2p3UjVwdCtmRVQ1eGNF?=
 =?utf-8?B?eXlLUitpejBuSVQ5QUx3MWtsNmlQR3dtcStwbTJCK0d4cnRzWkJ5NVFNdGtw?=
 =?utf-8?B?TWI5TXUvcnNLMEZSRWJFL3htd3FWc1pGOHQrVGlxM1lSY3BPS0ZKUm9yTlZ0?=
 =?utf-8?B?Vlc1MzlWYTEzWk1BM1JGUXdjQUUzcnh5V0pSNXRleTNwelFWRXl0RHVKaUsv?=
 =?utf-8?B?TEJtTittZjQvTkI5c0hwSStLSXR2N3FQNU0vZEg2RXZ0VTNpMEhoZG9sbk00?=
 =?utf-8?B?Q3FzUDlWWU9SNFhtY3FVUnRpWE9KTnBYYllpakhxdTY2U2VvZml3bEplNWcv?=
 =?utf-8?B?RUIzUmdTZXJ1ZEpaTlA4UFl6NGh1OC9QS1htKzZDUUplc3NaV3F3UFVlK0th?=
 =?utf-8?B?QzA3azFTYUxDQ01zYVAxYmNHVVl0Mlc4THN3SW5RaXNnMzhRdlVIV2xYSVIx?=
 =?utf-8?B?My9DM1U3c2VsWXBVY0JJeWc1VUkvK3BtVnhZeDlLblBXU3l0bU50cFowTit0?=
 =?utf-8?B?M2dCMFllYXZuNEl0NmRyTW5RT3NYL3ZPeUNqT3Z1b0xDeDR3UTNrblNJbTlv?=
 =?utf-8?B?Q2w2a0krVk02eTJQSGlFZlA5VXgrYjRoeExJSzNtYXRQQmZzNWppQm5NZndj?=
 =?utf-8?B?R3k2T2hZK2FQSHpKWjBmaXhsdUh2V1BjWUphVGtmaE42NXVWdVRHNUJUU0px?=
 =?utf-8?B?RkVCUmVmQVRjMVlEQmJCVW5UcnMzdkJjZ2pFWVlxMUp0dGJrNXVBV0FyMW9q?=
 =?utf-8?B?eHZQMzZWM3Fpck5vVVVzNEN5NEdtaGhBSFlDRGVmcTZvZmFQQko0S2N6Y1Vk?=
 =?utf-8?B?WVYyQUdKcTNMMUduREt1ZGZWUUovZXowbnlIVkFyZ0N3Q1NYUllVQTFPaWli?=
 =?utf-8?B?cG9MdWVLa1ZwQkN5bjl0WHJLN015Wm1oWEYrbzBaUjgzNHdkZjBKSDBWM1dR?=
 =?utf-8?Q?10+wOOTrP9yHPH7I5x1QIoqxfaCuZk8pNeoss=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlIzRHd5Z3lEWS9lZHp2enQwdnZJNnE0ekxLSkFmeHZnSWNFVWJrdzF2SjFR?=
 =?utf-8?B?a1JJUWY4M0tuUW1OZ2R3U01QWHdoclhTNno5VXVpREVKSEZJemxhUEY4WVZ1?=
 =?utf-8?B?aW9peENubVZFdXZLSGZENXlCQlk2amt6RzZBalFKUVlwUHRaSmpjanJMcUNq?=
 =?utf-8?B?R3ZtSWs3aFk2bFBmOHFydEwyZHV2MTNneVlWUjREV0lGTWVkUkg0VG5zeGNF?=
 =?utf-8?B?L0syMmVLV3BXM0NqYmpHWHF3enh6Y0d5ckI2dXdhQUZTc3hyWklBS1puNFBW?=
 =?utf-8?B?cVI5V0pEZnF6dmFBUWh0a2tkcHNKWFRpdUtpL3U1VzNneDFHT25mL3QwVzkr?=
 =?utf-8?B?MmowaTNsZjJRdTc4dkNqdmc3U3NjOXZtazVheVRRaFVKOHJDVEtXa2Z0elBO?=
 =?utf-8?B?SDlGZk9TRENUdHRpdkJsMG1Yd082WFRTa1o3MlpBRjFVWWp3QTM2M2NwdHV5?=
 =?utf-8?B?Z2N6NXNITUpnaUh3MlFTaVhmUjk0cVpwdThpUmJUbHFWa1BNZklPUi81dTIx?=
 =?utf-8?B?RDk3T3BDZWdyZGN5dXAxMnJsUzVjdlpzWWJmL2paYWJYSFFEOGtxM09jUkpT?=
 =?utf-8?B?TDFPWUVrU3p2N1ZVQUFWS3pJSkVJeEpZWXdSTEp4RUs0TWJuWUZpcFEzOHUv?=
 =?utf-8?B?cHRwR05YYzU0S0lWejVXcXBnS21tZUhyVUtxUTR5NHMyMzd3cU1QckMwTmtR?=
 =?utf-8?B?MVdGZ0tHKzJzaTZSb21EWEREYk5ILzlWU1l6bmFyVG5UWHY1d1ZIV2Fpcm1W?=
 =?utf-8?B?L1ViQi9wNWJQWXp5VmpBdFhva2k0bEc0NXlXK3huZmtzL2Z3Qm9KYXdSZnNX?=
 =?utf-8?B?QzNKOGtYcnBZaEVvOVFXK2liV0RleHNQNWlpMUFtY0UxUzNtRk90NDVYQlRU?=
 =?utf-8?B?czgvMGZORGh5ZmpEZHFJNmpBb2FROTZDall6K0pEc1pTVEFoTWpvd1NoWVNw?=
 =?utf-8?B?RzVPSkZNS1lsV3d5SVY5NHFpOTU1SFNKVE14NDN5VHE5Qy9HMHhTM211bVZ5?=
 =?utf-8?B?bExHR3BSY2UyT0kyV2hQbk84eU51bWZhTlFVV3BhcVFtYWN4N1hQSDlwcjkv?=
 =?utf-8?B?dXA2K0hBcE01bTFqWGZ2cW1hZnBKZUIwTEJCeXpIcit3Yi9XV1dDQVZwWHdB?=
 =?utf-8?B?bHV5TXpsemNxRGY0NnBnQUVTcHB0N1V0RWc5akFZZ1V2OHFIOWdEci9TaHNL?=
 =?utf-8?B?bmZEdzVRQmw4eE9uOUxvS09HWVpGajJzQmwvVEdjMm9FYUFlVFpRZHYvMjJC?=
 =?utf-8?B?RytQTmJGWGRGU3FrdllHdVB5SDM5ZFdnM3QzeGIycHVBdFUxYmEwZFVqUmJh?=
 =?utf-8?B?T0dtZVgrT1B4a1kzMFU3cGM5VlB2dVNxNGU0YlA0VjF4OW43UlpwVWlmOTNK?=
 =?utf-8?B?UnRPYVp0TG1RdjNlOThaR1N1RHBpc3ZOREJLakNrb0pheFJvMnJ3a243MlE2?=
 =?utf-8?B?TXFpeExIYThYcjVmUDZYZy81VTZGYm1VSTcxWGxURkdEUlF3aDdLdlpiWTNO?=
 =?utf-8?B?QXBWZVVzT2NESzJnR3JGL2Z2TjRkdmdNS2Qyam8rbkxZS1I0V09ycWh2TWZh?=
 =?utf-8?B?Q3JvclZMV0tvdHhkVVNHNjNhd2VwQ3hsVHNpNFRLdXIzSGRPc05XSXQwTThC?=
 =?utf-8?B?TFk3NU81MmZTVWFyc0lVT2R4TVg5Q2RmbUhCSm9MbmJlZkpPSHFHbXdSUkRQ?=
 =?utf-8?B?N25KMnNxc0NNbFZ3bTFidTQ4NXhrTnRRc2UwNjB2Y1g2Smk4RDdKS2JxQ00w?=
 =?utf-8?B?WTBORU1vRDFiV0hVRGc3S2xkTWt6VHVwWVJYVUowN2JXdWdwbDFXZThYZzJm?=
 =?utf-8?B?OEdiZzFKdjNUL1JSVWtCY1N6K2VCSEhUYWh2RTloVlFkb084ZWhCYW1HbjVy?=
 =?utf-8?B?NkpPYjV4Q0FRd3dTVzdVb2U1VHVvaGV2dWpubnFTWFJ2ZnpyaW9wZWsrb1cv?=
 =?utf-8?B?eGZVVXBkVlpzc21GaWU2TzdqU0pKVHg2elp0djJmTzNLWFpNVlp1eloyQWth?=
 =?utf-8?B?TFljWDQ3NE9LRTk2aHd5Szl6OGlHTWh5czVVNFBaMnh6Z2E2UWxVdFdmYnhm?=
 =?utf-8?B?ZkQrVVZMTjBGVnNFc1lLekxyYWhPbEtRWG9QN1Y0V1ZiSWdETVM5Qkp2OEs2?=
 =?utf-8?B?TGNXWXhlaWQ5bG1RbmUyZ2F1UlAyREpuWUZ6TlpmNTlTZlJaMXJEakdaUmRw?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9745F6DBAED473489324CB98B3FC66EC@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c8a019-1802-4e7f-9118-08dc9ffe66f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 10:03:37.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1Cw4Yxzsa/6oFjo3uPt50zcUeErsKvqOqyoETQMJnFLk21Ajp797NzmBILqBco8bzLSfQri9ybTaWuNWuW+iFGzFhh6+wwGKd97L0l0DKKGzEMcrJtai894eMlN/Niq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9239
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: PAVPR07MB9239.eurprd07.prod.outlook.com

DQoNCkxlIDA5LzA3LzIwMjQgw6AgMTE6MzksIEdyZWcgS0ggYSDDqWNyaXQgOg0KPiBPbiBUdWUs
IEp1bCAwOSwgMjAyNCBhdCAwOToyNDo1NEFNICswMDAwLCBMRVJPWSBDaHJpc3RvcGhlIHdyb3Rl
Og0KPj4NCj4+DQo+PiBMZSAwOS8wNy8yMDI0IMOgIDExOjE1LCBHcmVnIEtIIGEgw6ljcml0IDoN
Cj4+PiBPbiBNb24sIEp1bCAwOCwgMjAyNCBhdCAwMzoxMjo1NVBNICswMDAwLCBMRVJPWSBDaHJp
c3RvcGhlIHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+PiBMZSAwOC8wNy8yMDI0IMOgIDE0OjM2LCBH
cmVnIEtIIGEgw6ljcml0IDoNCj4+Pj4+IE9uIFN1biwgSnVsIDA3LCAyMDI0IGF0IDAzOjM0OjE1
UE0gKzA4MDAsIFdhbmdZdWxpIHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gT24gMjAyNC83LzYgMTc6
MzAsIEdyZWcgS0ggd3JvdGU6DQo+Pj4+Pj4+IFRoaXMgbWFrZXMgaXQgc291bmQgbGlrZSB5b3Ug
YXJlIHJldmVydGluZyB0aGlzIGJlY2F1c2Ugb2YgYSBidWlsZA0KPj4+Pj4+PiBlcnJvciwgd2hp
Y2ggaXMgbm90IHRoZSBjYXNlIGhlcmUsIHJpZ2h0PyAgSXNuJ3QgdGhpcyBiZWNhdXNlIG9mIHRo
ZQ0KPj4+Pj4+PiBwb3dlcnBjIGlzc3VlIHJlcG9ydGVkIGhlcmU6DQo+Pj4+Pj4+ICAgICAgIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA3MDUyMDM0MTMud2J2Mm53Mzc0N3ZqZWlia0Bh
bHRsaW51eC5vcmcNCj4+Pj4+Pj4gPw0KPj4+Pj4+DQo+Pj4+Pj4gTm8sIGl0IG9ubHkgb2NjdXJz
IG9uIEFSTTY0IGFyY2hpdGVjdHVyZS4gVGhlIHJlYXNvbiBpcyB0aGF0IGJlZm9yZSBiZWluZw0K
Pj4+Pj4+IG1vZGlmaWVkLCB0aGUgZnVuY3Rpb24NCj4+Pj4+Pg0KPj4+Pj4+IGJwZl9qaXRfYmlu
YXJ5X2xvY2tfcm8oKSBpbiBhcmNoL2FybTY0L25ldC9icGZfaml0X2NvbXAuYyArMTY1MQ0KPj4+
Pj4+DQo+Pj4+Pj4gd2FzIGludHJvZHVjZWQgd2l0aCBfX211c3RfY2hlY2ssIHdoaWNoIGlzIGRl
ZmluZWQgYXMNCj4+Pj4+PiBfX2F0dHJpYnV0ZV9fKChfX3dhcm5fdW51c2VkX3Jlc3VsdF9fKSku
DQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IEhvd2V2ZXIsIGF0IHRoaXMgcG9pbnQsIGNhbGxpbmcg
YnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpDQo+Pj4+Pj4gY29pbmNpZGVudGFsbHkgcmVz
dWx0cyBpbiBhbiB1bnVzZWQtcmVzdWx0DQo+Pj4+Pj4NCj4+Pj4+PiB3YXJuaW5nLg0KPj4+Pj4N
Cj4+Pj4+IE9rLCB0aGFua3MsIGJ1dCB3aHkgaXMgbm8gb25lIGVsc2Ugc2VlaW5nIHRoaXMgaW4g
dGhlaXIgdGVzdGluZz8NCj4+Pj4NCj4+Pj4gUHJvYmFibHkgdGhlIGNvbmZpZ3MgdXNlZCBieSBy
b2JvdHMgZG8gbm90IGFjdGl2YXRlIEJQRiBKSVQgPw0KPj4+Pg0KPj4+Pj4NCj4+Pj4+Pj4gSWYg
bm90LCB3aHkgbm90IGp1c3QgYmFja3BvcnQgdGhlIHNpbmdsZSBtaXNzaW5nIGFybTY0IGNvbW1p
dCwNCj4+Pj4+Pg0KPj4+Pj4+IFVwc3RyZWFtIGNvbW1pdCAxZGFkMzkxZGFlZjEgKCJicGYsIGFy
bTY0OiB1c2UgYnBmX3Byb2dfcGFjayBmb3IgbWVtb3J5DQo+Pj4+Pj4gbWFuYWdlbWVudCIpIGlz
IHBhcnQgb2YNCj4+Pj4+Pg0KPj4+Pj4+IGEgbGFyZ2VyIGNoYW5nZSB0aGF0IGludm9sdmVzIG11
bHRpcGxlIGNvbW1pdHMuIEl0J3Mgbm90IGFuIGlzb2xhdGVkIGNvbW1pdC4NCj4+Pj4+Pg0KPj4+
Pj4+DQo+Pj4+Pj4gV2UgY291bGQgY2VydGFpbmx5IGJhY2twb3J0IGFsbCBvZiB0aGVtIHRvIHNv
bHZlIHRoaXMgcHJvYmxlbSwgYnV0aGFzIGl0J3Mgbm90DQo+Pj4+Pj4gdGhlIHNpbXBsZXN0IHNv
bHV0aW9uLg0KPj4+Pj4NCj4+Pj4+IHJldmVydGluZyB0aGUgY2hhbmdlIGZlZWxzIHdyb25nIGlu
IHRoYXQgeW91IHdpbGwgc3RpbGwgaGF2ZSB0aGUgYnVnDQo+Pj4+PiBwcmVzZW50IHRoYXQgaXQg
d2FzIHRyeWluZyB0byBzb2x2ZSwgcmlnaHQ/ICBJZiBzbywgY2FuIHlvdSB0aGVuIHByb3ZpZGUN
Cj4+Pj4+IGEgd29ya2luZyB2ZXJzaW9uPw0KPj4+Pg0KPj4+PiBJbmRlZWQsIGJ5IHJldmVydGlu
ZyB0aGUgY2hhbmdlIHlvdSAicHVuaXNoIiBhbGwgYXJjaGl0ZWN0dXJlcyBiZWNhdXNlDQo+Pj4+
IGFybTY0IGhhc24ndCBwcm9wZXJseSBiZWVuIGJhY2twb3J0ZWQsIGlzIGl0IGZhaXIgPw0KPj4+
Pg0KPj4+PiBJbiBmYWN0LCB3aGVuIEkgaW1wbGVtZW50ZWQgY29tbWl0IGU2MGFkZjUxMzI3NSAo
ImJwZjogVGFrZSByZXR1cm4gZnJvbQ0KPj4+PiBzZXRfbWVtb3J5X3JveCgpIGludG8gYWNjb3Vu
dCB3aXRoIGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oKSIpLCB3ZSBoYWQNCj4+Pj4gdGhlIGZvbGxv
d2luZyB1c2VycyBmb3IgZnVuY3Rpb24gYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIDoNCj4+Pj4N
Cj4+Pj4gJCBnaXQgZ3JlcCBicGZfaml0X2JpbmFyeV9sb2NrX3JvIGU2MGFkZjUxMzI3NX4NCj4+
Pj4gZTYwYWRmNTEzMjc1fjphcmNoL2FybS9uZXQvYnBmX2ppdF8zMi5jOg0KPj4+PiBicGZfaml0
X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQo+Pj4+IGU2MGFkZjUxMzI3NX46YXJjaC9sb29uZ2Fy
Y2gvbmV0L2JwZl9qaXQuYzoNCj4+Pj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0K
Pj4+PiBlNjBhZGY1MTMyNzV+OmFyY2gvbWlwcy9uZXQvYnBmX2ppdF9jb21wLmM6DQo+Pj4+IGJw
Zl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+Pj4gZTYwYWRmNTEzMjc1fjphcmNoL3Bh
cmlzYy9uZXQvYnBmX2ppdF9jb3JlLmM6DQo+Pj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaml0
X2RhdGEtPmhlYWRlcik7DQo+Pj4+IGU2MGFkZjUxMzI3NX46YXJjaC9zMzkwL25ldC9icGZfaml0
X2NvbXAuYzoNCj4+Pj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KPj4+PiBlNjBh
ZGY1MTMyNzV+OmFyY2gvc3BhcmMvbmV0L2JwZl9qaXRfY29tcF82NC5jOg0KPj4+PiBicGZfaml0
X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQo+Pj4+IGU2MGFkZjUxMzI3NX46YXJjaC94ODYvbmV0
L2JwZl9qaXRfY29tcDMyLmM6DQo+Pj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsN
Cj4+Pj4gZTYwYWRmNTEzMjc1fjppbmNsdWRlL2xpbnV4L2ZpbHRlci5oOnN0YXRpYyBpbmxpbmUg
dm9pZA0KPj4+PiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKHN0cnVjdCBicGZfYmluYXJ5X2hlYWRl
ciAqaGRyKQ0KPj4+Pg0KPj4+PiBCdXQgd2hlbiBjb21taXQgMDhmNmMwNWZlYjFkICgiYnBmOiBU
YWtlIHJldHVybiBmcm9tIHNldF9tZW1vcnlfcm94KCkNCj4+Pj4gaW50byBhY2NvdW50IHdpdGgg
YnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIikgd2FzIGFwcGxpZWQsIHdlIGhhZCBvbmUNCj4+Pj4g
bW9yZSB1c2VyIHdoaWNoIGlzIGFybTY0Og0KPj4+Pg0KPj4+PiAkIGdpdCBncmVwIGJwZl9qaXRf
YmluYXJ5X2xvY2tfcm8gMDhmNmMwNWZlYjFkfg0KPj4+PiAwOGY2YzA1ZmViMWR+OmFyY2gvYXJt
L25ldC9icGZfaml0XzMyLmM6DQo+Pj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsN
Cj4+Pj4gMDhmNmMwNWZlYjFkfjphcmNoL2FybTY0L25ldC9icGZfaml0X2NvbXAuYzoNCj4+Pj4g
YnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KPj4+PiAwOGY2YzA1ZmViMWR+OmFyY2gv
bG9vbmdhcmNoL25ldC9icGZfaml0LmM6DQo+Pj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVh
ZGVyKTsNCj4+Pj4gMDhmNmMwNWZlYjFkfjphcmNoL21pcHMvbmV0L2JwZl9qaXRfY29tcC5jOg0K
Pj4+PiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKGhlYWRlcik7DQo+Pj4+IDA4ZjZjMDVmZWIxZH46
YXJjaC9wYXJpc2MvbmV0L2JwZl9qaXRfY29yZS5jOg0KPj4+PiBicGZfaml0X2JpbmFyeV9sb2Nr
X3JvKGppdF9kYXRhLT5oZWFkZXIpOw0KPj4+PiAwOGY2YzA1ZmViMWR+OmFyY2gvczM5MC9uZXQv
YnBmX2ppdF9jb21wLmM6DQo+Pj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+
Pj4gMDhmNmMwNWZlYjFkfjphcmNoL3NwYXJjL25ldC9icGZfaml0X2NvbXBfNjQuYzoNCj4+Pj4g
YnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KPj4+PiAwOGY2YzA1ZmViMWR+OmFyY2gv
eDg2L25ldC9icGZfaml0X2NvbXAzMi5jOg0KPj4+PiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKGhl
YWRlcik7DQo+Pj4+IDA4ZjZjMDVmZWIxZH46aW5jbHVkZS9saW51eC9maWx0ZXIuaDpzdGF0aWMg
aW5saW5lIHZvaWQNCj4+Pj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhzdHJ1Y3QgYnBmX2JpbmFy
eV9oZWFkZXIgKmhkcikNCj4+Pj4NCj4+Pj4gVGhlcmVmb3JlLCBjb21taXQgMDhmNmMwNWZlYjFk
IHNob3VsZCBoYXZlIGluY2x1ZGVkIGEgYmFja3BvcnQgZm9yIGFybTY0Lg0KPj4+Pg0KPj4+PiBT
byB5ZXMsIEkgYWdyZWUgd2l0aCBHcmVnLCB0aGUgY29ycmVjdCBmaXggc2hvdWxkIGJlIHRvIGJh
Y2twb3J0IHRvDQo+Pj4+IEFSTTY0IHRoZSBjaGFuZ2VzIGRvbmUgb24gb3RoZXIgYXJjaGl0ZWN0
dXJlcyBpbiBvcmRlciB0byBwcm9wZXJseQ0KPj4+PiBoYW5kbGUgcmV0dXJuIG9mIHNldF9tZW1v
cnlfcm94KCkgaW4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpLg0KPj4+DQo+Pj4gT2ssIGJ1dCBp
dCBsb29rcyBsaWtlIGR1ZSB0byB0aGlzIHNlcmllcywgdGhlIHBvd2VycGMgdHJlZSBpcyBjcmFz
aGluZw0KPj4+IGF0IHRoZSBmaXJzdCBicGYgbG9hZCwgc28gc29tZXRoaW5nIHdlbnQgd3Jvbmcu
ICBMZXQgbWUgZ28gcmV2ZXJ0IHRoZXNlDQo+Pj4gNCBwYXRjaGVzIGZvciBub3csIGFuZCB0aGVu
IEkgd2lsbCBiZSBnbGFkIHRvIHF1ZXVlIHRoZW0gdXAgaWYgeW91IGNhbg0KPj4+IHByb3ZpZGUg
YSB3b3JraW5nIHNlcmllcyBmb3IgYWxsIGFyY2hlcy4NCj4+Pg0KPj4NCj4+IEZhaXIgZW5vdWdo
LCBpbmRlZWQgSSB0aGluayBmb3IgcG93ZXJwYyBpdCBwcm9iYWJseSBhbHNvIHJlbGllcyBvbiBt
b3JlDQo+PiBjaGFuZ2VzLCBzbyBib3RoIEFSTSBhbmQgUE9XRVJQQyBuZWVkIGEgY2FyZWZ1bGwg
YmFja3BvcnQuDQo+Pg0KPj4gSSBjYW4gbG9vayBhdCBpdCwgYnV0IGNhbiB5b3UgdGVsbCB3aHkg
aXQgd2FzIGRlY2lkZWQgdG8gYXBwbHkgdGhhdA0KPj4gY29tbWl0IG9uIHN0YWJsZSBhdCB0aGUg
Zmlyc3QgcGxhY2UgPyBJcyB0aGVyZSBhIHBhcnRpY3VsYXIgbmVlZCA/DQo+DQo+IEJhc2VkIG9u
IHRoZSBjaGFuZ2Vsb2cgdGV4dCBpdHNlbGYsIGl0IGZpeGVzIGFuIGlzc3VlIGFuZCB3YXMgZmxh
Z2dlZCBhcw0KPiBzb21ldGhpbmcgdG8gYmUgYmFja3BvcnRlZC4NCj4NCj4gSWYgdGhpcyBpc24n
dCBuZWVkZWQgaW4gNi42LnksIHRoZW4gbm8gd29ycmllcyBhdCBhbGwsIHdlIGNhbiBqdXN0IGRy
b3ANCj4gdGhlbSBhbmQgYmUgaGFwcHkgOikNCj4NCg0KSW4gZmFjdCB0aGlzIGNoYW5nZSBpcyBw
YXJ0IG9mIGEgbG9uZy10ZXJtIGhhcmRlbmluZyBlZmZvcnQgYXMgZGVzY3JpYmVkDQppbiBodHRw
czovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNw0KDQpJJ20gbm90IHN1cmUgaXQncyB3
b3J0aCBwaWNraW5nIGl0IHVwIG9uIGl0cyBvd24sIHNvIEkgcHJvcG9zZSB0byBub3QgZG8NCmFu
eXRoaW5nIHVubGVzcyBzb21lb25lIHJhaXNlcyB0aGVpciBoYW5kLg0KDQpDaHJpc3RvcGhlDQo=

