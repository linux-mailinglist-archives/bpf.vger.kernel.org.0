Return-Path: <bpf+bounces-34212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1392B3BD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E881C220C2
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BC155385;
	Tue,  9 Jul 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="r6uLKhtB"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0A155333;
	Tue,  9 Jul 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517100; cv=fail; b=f/AJY/5JwDHG0OWu6GzkoKNw0wczMvtNPqfEhDZZzIRiQtrxWzEp3Sj/WAsvPmb65q381n+OBbx83W28DiXSDoj+Q3qo+TpzgbHsRFiw5OawWsC886s4FIf/gJ3MCwMnHpwnauJi3eOypgPMKH2GTAmayLyCoHpQI8xrvevpLpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517100; c=relaxed/simple;
	bh=u9uVs2LKwsmMelUBAB6DDqx+rMyK9ckCk6q6HQso4cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N48nFzfJCK/bB4IXh4LGmvma6OtBuJ/HQRtdQTnxHMU+es8BuPu7U1CT4WPwR+vJ0tS6Q2p0yRU1TldekT13e5ChMG1PH8vyD00hX2f/lhX9GA946BUKj5K0SIPkLR3eUVAEUSBTZJLx3OO6iYzPrYEQhT7W2T7Fjhk9kQKNguo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=r6uLKhtB; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqUfEMcjcrV59dlUWcLLMbHm4McvoG3bptFYg8/QQU9ve3S9xOPrwtKl2/HcO63GEUeareQjSNM8GK+T5RYYemA7rd6aUys8wxBO1cO2Wd/0qlgJzitd55HJOMvdw4Venz8aTIjxALy279/d7k49/8loBrjNtoZ+anE26FGN8yDyAaEZr/pvckO3Wf8YA47+vBy8vwO9QVOpQ1g8TiepKdEalA9eu+O9IlC5LJzgm/aMh6R78NSQkEyIlNjrsrE73pj+uJjXOLS07fbcIbSJ/3IQ8u5iQ/NsO9qgJCeOGxXFe+7fYUyNEKLK05eSznayyMjSceEBz1WTlW87xif76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9uVs2LKwsmMelUBAB6DDqx+rMyK9ckCk6q6HQso4cU=;
 b=MRRqXvSVBjFfOvpzmKj41XBZW7ttea6fvosCC/kysk06Zxk/Fb+0cYmxUw9SemJoEMCyQFNW2LulIJ+Rr6LD8byB4BUwu2rdID1HV1W1f4HI3oYeoiyOq7WoHPDG9qTAbpn5QhprrAyk0f/n7ut+zyI5bopH8KVVnwV3yf8IlJL6wxOrKKmCrz8p0I/iUAloR4S88x9FnbL5wQFN5s0ww9hwN8t0esOY4rYRWrxh/waZUJJyYYP+dN2B81wXsHcAYK2N+kjAzCU+7Zzl4WJmVWiGvofFXme3uhYJFrIuAAi/YyKcnrkCnVlFIQcqmrKPNvZI8tb4HBOl/ZSRfdHp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9uVs2LKwsmMelUBAB6DDqx+rMyK9ckCk6q6HQso4cU=;
 b=r6uLKhtBuiOlZC3KUV3QVO/bprfVHbR7rDCkuPeEefWX//V/bMYThNkWfTjZJ/zN5zt+xOBH8nfRUS7GcFLHUmolTFC9Hx5R6MrX3LLbDXAQ/yOpleQbGt8VGC6esGmeNB4jXIlxXZe354Vir4jhvkr8FnxBLW8YEELouMYnP+GSfHha9gx9fWUYL94HHM7aSh5TlWzKVDW+Y4Zzw3jlN/ti3v2FYSrnWG13KfozaH6JIQQUoumUtIrVfrMEqid+sXwKa28xNZQA+VYLMX1aVARLaCOtwZF8rlJY8SzfVQts1zHUpJ1Jk/yQgB9WBA5Kdv3zNLWEv9x+vvWnnrnGrg==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AM0PR07MB6323.eurprd07.prod.outlook.com (2603:10a6:20b:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 09:24:54 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 09:24:54 +0000
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
 AQHaz1JvmhkZvbTHdkOR2W9HlG+2VbHpb4AAgAFx/oCAAebSgIAAK6gAgAEumYCAAAJ+AA==
Date: Tue, 9 Jul 2024 09:24:54 +0000
Message-ID: <4d07cfa3-031c-45f4-aec1-9f0a54dd22b2@cs-soprasteria.com>
References: <5A29E00D83AB84E3+20240706031101.637601-1-wangyuli@uniontech.com>
 <2024070631-unrivaled-fever-8548@gregkh>
 <B7E3B29557B78CB1+afadbaa6-987e-4db4-96b5-4e4d5465c37b@uniontech.com>
 <2024070815-udder-charging-7f75@gregkh>
 <a1dac525-4e6d-4d28-87ee-63723abbafad@cs-soprasteria.com>
 <2024070908-glade-granny-1137@gregkh>
In-Reply-To: <2024070908-glade-granny-1137@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AM0PR07MB6323:EE_
x-ms-office365-filtering-correlation-id: 4f83af2f-564d-479d-67ff-08dc9ff8fe49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDRIWEEzc092Z1FtcUJVN1VZeXp1dlp2SGdIbDlLZHFjL1pLdnNVWEgxN2ZQ?=
 =?utf-8?B?ZWorWkw1UzdmeGdJbmRXd2gwZXk1Nzd5dUtNYmlKTTBmZFZKajRnSjZscEFM?=
 =?utf-8?B?L0JabS9jZHBZMHdRdzI3S2FKZnl4Q3BWeWRYUEw0M1RJY3NHNXhiZCtnZXRm?=
 =?utf-8?B?dHR6THdtdTlYM2ZNaDlVR2tkdkhFSjl4bW1nUVVjU09XakN1c090SElxRXpZ?=
 =?utf-8?B?NkNIWHRDWkg0cFVaUGdvYzNKK3FacDZLYkhldHA2blRZTEdpc1Jic1ZHakJs?=
 =?utf-8?B?STFFdzF6Q281QllQL0duSEtKTitYL1QzNXB6MGRkQVJ4MUxQSHRPS1Rzd3RO?=
 =?utf-8?B?dTdSYnp5eHVURGUvbnZFTnRNVXpSMGdmdXZiMVJrQmpXS0g3N3h3S3F6Rnky?=
 =?utf-8?B?U3pwajBzeFYxcVduVlhnTTRwbUZaUW0wMS92THF5ZWhHdTMvanpBbXN3Tmcv?=
 =?utf-8?B?SVk4VU5UVU5kZWtjbSsxeERyRDVhRTM2U0NldzI0cGVrOHRzdDBxWTVsS3Bl?=
 =?utf-8?B?cE9NcWRKS2NMV3luVlhiajNpeFQ4N2tmZ2ZkVUlJcnF3RjRNbURYZ0xNRWJF?=
 =?utf-8?B?S2VLS1ArTVdRTS9qb3NmTlFXdHMvTzdqamxUcjRkYWtyYllXUUYzMlZuaEgz?=
 =?utf-8?B?OXJsMGJOTHZFczVWWTlQNmZ1SEZrcVQraXFTZmxVSmk0OU9NQnNNUGNVdTEx?=
 =?utf-8?B?dTdRbUpNZjRHZnZ1NkZQcmFWZEtVUjVsM3RUUHVpOE8vaG1NVUtFdjNZaXgz?=
 =?utf-8?B?Z0MvMTJ1dmJBajBHL2s0WWRoU3FteHg1U29mZ3J1YjhrbWs1T0pwRnRGWGd6?=
 =?utf-8?B?ZjU3RU44NmR1Wkd0NXhsbXpZWjJiUjVFOVRjbVB5YWREUEZFN00wcDlHcExw?=
 =?utf-8?B?anNCaFYyUFNMcmlacTMzaVVXMnlqTkpMb3JOYjNJQzVnMi9VNDh1NU8vZlZs?=
 =?utf-8?B?WG4vWjZwZ0ZzS0VsTldMbEo2Q1Z2QmRSenhmSENGRjNtWE12VHk4RFpqMWQ1?=
 =?utf-8?B?TlJDdkQyUUNBN1lRc01DN1NVSU04UittNjd6Nk45WUc3bkZkdHZLQVNCeFJH?=
 =?utf-8?B?UnllNjJudVozR3NHZ1U2WWxJczRkcjRVa0kwSWFjYTVpaU5mN2V2bDJuY2Zq?=
 =?utf-8?B?SXQzdnFlM0N0NGNRUFhPNXZXMUZMeWJYRFZQalg4elFpaEsyU2FMY2w4VGRD?=
 =?utf-8?B?dDdFWmZJbHp5MUFxeTREMHIwcFZxVnQwZm05MkF5MDU1UTRySm9uUlZRYzFp?=
 =?utf-8?B?VHcvaFhVMEhzQzNVKyt1NWpFOURhZ01DYTZOY0dzSFByYUZnQ2JWUUNTL040?=
 =?utf-8?B?cHB3L1ZYVHFvS1hka1pCcmkzVkt1K3EvSjF4WVVGTmdmOU5lQkZaT2R5UlUz?=
 =?utf-8?B?Mlc0ZFd4LytoM001TGJoOHpWMkxEV2dzbzYycmlxSjd4cUx1ZnFqNnZYQVhO?=
 =?utf-8?B?cU94eGtnN0ZYUUZVRmRQeTJUMmlYS3NTZ0ZaT1REbk1INGVBbDMxeTE2MXpZ?=
 =?utf-8?B?OG4yT2hYaDlOVElYSFV1V0x3MDhVYkJQaUkwMHRRNmJWYUxVMkdNcE0zYStt?=
 =?utf-8?B?cEo3M2RlbkY3dDdZeFA3QnV4cGhqSmtLWUJPa1F2L212QnRnWW1hY3N0L01X?=
 =?utf-8?B?NFV4T0hHQThGZ0swRDRXRVIwd2h0bmZyYWpid0RYdkxZVFJEL3pYVGhzVUhT?=
 =?utf-8?B?WExacllrWkdUSnVoMnJ1NTFHRDIxYmkrWG5WMkV2VU1JQ1hwTll6eGQ1ZkJk?=
 =?utf-8?B?SUluTnl6dVBOVmFib3FWVVlSVUlPdEg1UjZjL2Fqb0tHOHF2RWdEemxxUURw?=
 =?utf-8?Q?j/CCGL/wyGATK6+gXRCXu1SKsRWMqCasNqxPc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym5WcEdGc3RRcS9uQXpIUFluQnZpK0FhVVJMRDJZTjJDZHkybUNobXUrTmMx?=
 =?utf-8?B?NHlLUHhYTVVuNitYM2dCcHBkaForZkptbGl6SkwzZjBUckZVZkZiY1d4ZGhl?=
 =?utf-8?B?RjU3cm1KQ3hhSi9rZ1B0T1I0SStIN0ZnSWs5TkhHNVFzYXU2SkE2aFF2cVgx?=
 =?utf-8?B?b0dCNytySThlNUZaRlJjQ1MycDM2SExRSGd5S1pTRHFLZ2lpUDI2ODAyNm9P?=
 =?utf-8?B?Q3Z2Y3hMWWxrVUMvTVFMZmVtYmpRZ3ZoUGE5M21BR1RHNGZWektibXVxYlhT?=
 =?utf-8?B?a3NNaC9uRmx6ZS84SGZqQnNlMlBmSGFRMGdtaHhVMzhkTERwUnEzN1p1L2FJ?=
 =?utf-8?B?aXplZ2tJVHAvcFFISC9qWlZSUlRqdDRERnJ4MzhJM3BKK2NZRmY1TDFvRC9m?=
 =?utf-8?B?VGd6OXBxSzhTbUVmZ0pGaGc0cUpPV3BxMEFYRFZKQk1MQzZ1aTZ2QWhXSmlE?=
 =?utf-8?B?UlNjVUVnNDNvZ3BXbDFaQktScEsvMzVDcTBRdEpiMjZZMFhZVFpVNkZmQnAy?=
 =?utf-8?B?QlIxclArMnlqWlpFd2VCRis5TTF1NzJlSjNMSU5SRFVlbmRqbElFVE04eXNj?=
 =?utf-8?B?dU42ZmlsUnA0YnhFRXBUSHY0Zm80b0FsaTM0YWcvdEJiaWNDTUdJY0xzUEUv?=
 =?utf-8?B?bENtbjRJV1NEM3M3bjRiNm9ZN0Foa016WmRGQXp1dXU0NHg1NlRUMVZDQUlw?=
 =?utf-8?B?Y0l1NVN1NGZTUzRPbldrSGJpUDJlT3pic29UUWtvaDdHQWtYdWgwdmlZTjUx?=
 =?utf-8?B?YzE2aGN4YXhkdGtueTJ2aEFDcnRuZlo1RjJ3SFVGeitmeTd2a1c3ZVc4MjRk?=
 =?utf-8?B?QUZFRGt2KzFZVG4wbjU5VFpiVnIwSkJUV3BrUHJXMThBTFNsc21sQkVVRTBq?=
 =?utf-8?B?RjJ3YWFTcGpYM3FhOFNlYXpWSW5vS1Y0aDAzNDRjMEpxUHRKYjlpanlxaWly?=
 =?utf-8?B?dDNuMm95UDlyaHZCUDFQR1hCOWlFRktndTEyaXpMQW82eWN2RTZPUDBNTjVm?=
 =?utf-8?B?VWVIUTdvakM1RUJZQlA3ZXVDeGtqeTZZN1RzdE9zd3lndU9sWUJkMEZWYjZG?=
 =?utf-8?B?UVd6dU5PMXI5SUh3Tm96QWpnS3dBaitNTGpCYzVwN1gxNmRmRUgyYm14ZGlX?=
 =?utf-8?B?RllKTmpyZmZXRGRlZ08wVzh6WGFrVzdXeFJYREI2ZHJyQ0tXTEtIeGtaNCtH?=
 =?utf-8?B?YlBoY09sMlVjdkErZXZSdVNoVVhjY1F4TDFQWHg3ZXZ4VG1DYUEyaHNxczlp?=
 =?utf-8?B?RGNPUFZJVnRTbGJWaThLZTZibE5VUUl2OG5NQzRJZ1diMEpQaFhHSGYzMDhK?=
 =?utf-8?B?RlRzZEFkVW1aSURBbFFZcENBWnR6cmp0VDJzU25IaHFyUXBmelUvOWFzT05V?=
 =?utf-8?B?Y0d2M2x5aWpqMUhDWjhtaVlxa2dFT2p3T1VoYzNCQ1FvVGFFZktOUlJVTXNi?=
 =?utf-8?B?MGY4Z2paTk5QUE1sZk12WUdzelJ1aGExT1dtcG9KQnZsZWJSMjVSQmtWU3o5?=
 =?utf-8?B?bjV5YVo3UUpVMWRLMXB0TGgyYWI3Z0RRemRrS0hnRDhKbWNTWE1ILzJ0bVAw?=
 =?utf-8?B?Zkc1bnBjd1BHYTZ5dDYyMTRmZXB6T0lkOGE0SUF0aEhGOVlEeDMzc0VNYVNQ?=
 =?utf-8?B?d1dqQUR3Q1BCWS9aSktSRGQwUGhVNnpVV1NzOEJUUGpJZkNwTFdkOFl6Wllh?=
 =?utf-8?B?VUF4dGVVY3NlQ3hKNjUwN3ZRY20rcG8zQjF3THdtazV1VVFBd2RUdjZndDVP?=
 =?utf-8?B?a1cweEFrZEtTQkpIRFAzVU04bDA2aEoxU3NwYitndk00bXFmL2Noekp0ODFP?=
 =?utf-8?B?UVdxUTNEaHZhSys1b2d1YUg5SDJmVlErUFFqK3R3YWQrUVl3ZDdPODc4cE9x?=
 =?utf-8?B?R01renAxUHlmRVROeUpSVGtkWG5VLzBRU2dBN3dRbUlOZjVYdkZDNzVvSDFV?=
 =?utf-8?B?aVlMLzF3Qng4MXJKOXlKMk5NVk5Lc3V5V0xFYnAwVDlWWURVRU53dndxN1JS?=
 =?utf-8?B?cmh0K1gxNzBmelAxdnd5YjF2U1dMMytOUDk4WDkzRHZ2TUNhMFpxclRaY29W?=
 =?utf-8?B?ejFiRWFGZk9BSHptNWRjTDNISXFqeldxb0JyWTdudElqamM3bFJkRkdZUE44?=
 =?utf-8?B?dDNIYnhKZlUvQUI3cFlTWUtINC9WUFp3ZFZJY3YwN0Uvcis0eGgyVGU2a1lC?=
 =?utf-8?Q?eTkW2pIASuQnyGL8Jf8ohIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28F20A0BA7CDFC48AB47CD7C9B8C8D2D@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f83af2f-564d-479d-67ff-08dc9ff8fe49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 09:24:54.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pPZFO5+IHhNhtl0Nk2YWD0H3j6VxPN2OLLxlhfF7dSoacVLxfPcv5lj5I1WOUCwpu9E9FHw83eelW3N6yCYuL6pjrVQzFVs5ojptupWg2A3EnLOwxPcejt6XUBSGeNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6323
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
X-OrganizationHeadersPreserved: AM0PR07MB6323.eurprd07.prod.outlook.com

DQoNCkxlIDA5LzA3LzIwMjQgw6AgMTE6MTUsIEdyZWcgS0ggYSDDqWNyaXQgOg0KPiBPbiBNb24s
IEp1bCAwOCwgMjAyNCBhdCAwMzoxMjo1NVBNICswMDAwLCBMRVJPWSBDaHJpc3RvcGhlIHdyb3Rl
Og0KPj4NCj4+DQo+PiBMZSAwOC8wNy8yMDI0IMOgIDE0OjM2LCBHcmVnIEtIIGEgw6ljcml0IDoN
Cj4+PiBPbiBTdW4sIEp1bCAwNywgMjAyNCBhdCAwMzozNDoxNVBNICswODAwLCBXYW5nWXVsaSB3
cm90ZToNCj4+Pj4NCj4+Pj4gT24gMjAyNC83LzYgMTc6MzAsIEdyZWcgS0ggd3JvdGU6DQo+Pj4+
PiBUaGlzIG1ha2VzIGl0IHNvdW5kIGxpa2UgeW91IGFyZSByZXZlcnRpbmcgdGhpcyBiZWNhdXNl
IG9mIGEgYnVpbGQNCj4+Pj4+IGVycm9yLCB3aGljaCBpcyBub3QgdGhlIGNhc2UgaGVyZSwgcmln
aHQ/ICBJc24ndCB0aGlzIGJlY2F1c2Ugb2YgdGhlDQo+Pj4+PiBwb3dlcnBjIGlzc3VlIHJlcG9y
dGVkIGhlcmU6DQo+Pj4+PiAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA3MDUy
MDM0MTMud2J2Mm53Mzc0N3ZqZWlia0BhbHRsaW51eC5vcmcNCj4+Pj4+ID8NCj4+Pj4NCj4+Pj4g
Tm8sIGl0IG9ubHkgb2NjdXJzIG9uIEFSTTY0IGFyY2hpdGVjdHVyZS4gVGhlIHJlYXNvbiBpcyB0
aGF0IGJlZm9yZSBiZWluZw0KPj4+PiBtb2RpZmllZCwgdGhlIGZ1bmN0aW9uDQo+Pj4+DQo+Pj4+
IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oKSBpbiBhcmNoL2FybTY0L25ldC9icGZfaml0X2NvbXAu
YyArMTY1MQ0KPj4+Pg0KPj4+PiB3YXMgaW50cm9kdWNlZCB3aXRoIF9fbXVzdF9jaGVjaywgd2hp
Y2ggaXMgZGVmaW5lZCBhcw0KPj4+PiBfX2F0dHJpYnV0ZV9fKChfX3dhcm5fdW51c2VkX3Jlc3Vs
dF9fKSkuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEhvd2V2ZXIsIGF0IHRoaXMgcG9pbnQsIGNhbGxpbmcg
YnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpDQo+Pj4+IGNvaW5jaWRlbnRhbGx5IHJlc3Vs
dHMgaW4gYW4gdW51c2VkLXJlc3VsdA0KPj4+Pg0KPj4+PiB3YXJuaW5nLg0KPj4+DQo+Pj4gT2ss
IHRoYW5rcywgYnV0IHdoeSBpcyBubyBvbmUgZWxzZSBzZWVpbmcgdGhpcyBpbiB0aGVpciB0ZXN0
aW5nPw0KPj4NCj4+IFByb2JhYmx5IHRoZSBjb25maWdzIHVzZWQgYnkgcm9ib3RzIGRvIG5vdCBh
Y3RpdmF0ZSBCUEYgSklUID8NCj4+DQo+Pj4NCj4+Pj4+IElmIG5vdCwgd2h5IG5vdCBqdXN0IGJh
Y2twb3J0IHRoZSBzaW5nbGUgbWlzc2luZyBhcm02NCBjb21taXQsDQo+Pj4+DQo+Pj4+IFVwc3Ry
ZWFtIGNvbW1pdCAxZGFkMzkxZGFlZjEgKCJicGYsIGFybTY0OiB1c2UgYnBmX3Byb2dfcGFjayBm
b3IgbWVtb3J5DQo+Pj4+IG1hbmFnZW1lbnQiKSBpcyBwYXJ0IG9mDQo+Pj4+DQo+Pj4+IGEgbGFy
Z2VyIGNoYW5nZSB0aGF0IGludm9sdmVzIG11bHRpcGxlIGNvbW1pdHMuIEl0J3Mgbm90IGFuIGlz
b2xhdGVkIGNvbW1pdC4NCj4+Pj4NCj4+Pj4NCj4+Pj4gV2UgY291bGQgY2VydGFpbmx5IGJhY2tw
b3J0IGFsbCBvZiB0aGVtIHRvIHNvbHZlIHRoaXMgcHJvYmxlbSwgYnV0aGFzIGl0J3Mgbm90DQo+
Pj4+IHRoZSBzaW1wbGVzdCBzb2x1dGlvbi4NCj4+Pg0KPj4+IHJldmVydGluZyB0aGUgY2hhbmdl
IGZlZWxzIHdyb25nIGluIHRoYXQgeW91IHdpbGwgc3RpbGwgaGF2ZSB0aGUgYnVnDQo+Pj4gcHJl
c2VudCB0aGF0IGl0IHdhcyB0cnlpbmcgdG8gc29sdmUsIHJpZ2h0PyAgSWYgc28sIGNhbiB5b3Ug
dGhlbiBwcm92aWRlDQo+Pj4gYSB3b3JraW5nIHZlcnNpb24/DQo+Pg0KPj4gSW5kZWVkLCBieSBy
ZXZlcnRpbmcgdGhlIGNoYW5nZSB5b3UgInB1bmlzaCIgYWxsIGFyY2hpdGVjdHVyZXMgYmVjYXVz
ZQ0KPj4gYXJtNjQgaGFzbid0IHByb3Blcmx5IGJlZW4gYmFja3BvcnRlZCwgaXMgaXQgZmFpciA/
DQo+Pg0KPj4gSW4gZmFjdCwgd2hlbiBJIGltcGxlbWVudGVkIGNvbW1pdCBlNjBhZGY1MTMyNzUg
KCJicGY6IFRha2UgcmV0dXJuIGZyb20NCj4+IHNldF9tZW1vcnlfcm94KCkgaW50byBhY2NvdW50
IHdpdGggYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIiksIHdlIGhhZA0KPj4gdGhlIGZvbGxvd2lu
ZyB1c2VycyBmb3IgZnVuY3Rpb24gYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIDoNCj4+DQo+PiAk
IGdpdCBncmVwIGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8gZTYwYWRmNTEzMjc1fg0KPj4gZTYwYWRm
NTEzMjc1fjphcmNoL2FybS9uZXQvYnBmX2ppdF8zMi5jOg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9j
a19ybyhoZWFkZXIpOw0KPj4gZTYwYWRmNTEzMjc1fjphcmNoL2xvb25nYXJjaC9uZXQvYnBmX2pp
dC5jOg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KPj4gZTYwYWRmNTEzMjc1
fjphcmNoL21pcHMvbmV0L2JwZl9qaXRfY29tcC5jOg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19y
byhoZWFkZXIpOw0KPj4gZTYwYWRmNTEzMjc1fjphcmNoL3BhcmlzYy9uZXQvYnBmX2ppdF9jb3Jl
LmM6DQo+PiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKGppdF9kYXRhLT5oZWFkZXIpOw0KPj4gZTYw
YWRmNTEzMjc1fjphcmNoL3MzOTAvbmV0L2JwZl9qaXRfY29tcC5jOg0KPj4gYnBmX2ppdF9iaW5h
cnlfbG9ja19ybyhoZWFkZXIpOw0KPj4gZTYwYWRmNTEzMjc1fjphcmNoL3NwYXJjL25ldC9icGZf
aml0X2NvbXBfNjQuYzoNCj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+IGU2
MGFkZjUxMzI3NX46YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcDMyLmM6DQo+PiBicGZfaml0X2Jp
bmFyeV9sb2NrX3JvKGhlYWRlcik7DQo+PiBlNjBhZGY1MTMyNzV+OmluY2x1ZGUvbGludXgvZmls
dGVyLmg6c3RhdGljIGlubGluZSB2b2lkDQo+PiBicGZfaml0X2JpbmFyeV9sb2NrX3JvKHN0cnVj
dCBicGZfYmluYXJ5X2hlYWRlciAqaGRyKQ0KPj4NCj4+IEJ1dCB3aGVuIGNvbW1pdCAwOGY2YzA1
ZmViMWQgKCJicGY6IFRha2UgcmV0dXJuIGZyb20gc2V0X21lbW9yeV9yb3goKQ0KPj4gaW50byBh
Y2NvdW50IHdpdGggYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpIikgd2FzIGFwcGxpZWQsIHdlIGhh
ZCBvbmUNCj4+IG1vcmUgdXNlciB3aGljaCBpcyBhcm02NDoNCj4+DQo+PiAkIGdpdCBncmVwIGJw
Zl9qaXRfYmluYXJ5X2xvY2tfcm8gMDhmNmMwNWZlYjFkfg0KPj4gMDhmNmMwNWZlYjFkfjphcmNo
L2FybS9uZXQvYnBmX2ppdF8zMi5jOg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIp
Ow0KPj4gMDhmNmMwNWZlYjFkfjphcmNoL2FybTY0L25ldC9icGZfaml0X2NvbXAuYzoNCj4+IGJw
Zl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+IDA4ZjZjMDVmZWIxZH46YXJjaC9sb29u
Z2FyY2gvbmV0L2JwZl9qaXQuYzoNCj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsN
Cj4+IDA4ZjZjMDVmZWIxZH46YXJjaC9taXBzL25ldC9icGZfaml0X2NvbXAuYzoNCj4+IGJwZl9q
aXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+IDA4ZjZjMDVmZWIxZH46YXJjaC9wYXJpc2Mv
bmV0L2JwZl9qaXRfY29yZS5jOg0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhqaXRfZGF0YS0+
aGVhZGVyKTsNCj4+IDA4ZjZjMDVmZWIxZH46YXJjaC9zMzkwL25ldC9icGZfaml0X2NvbXAuYzoN
Cj4+IGJwZl9qaXRfYmluYXJ5X2xvY2tfcm8oaGVhZGVyKTsNCj4+IDA4ZjZjMDVmZWIxZH46YXJj
aC9zcGFyYy9uZXQvYnBmX2ppdF9jb21wXzY0LmM6DQo+PiBicGZfaml0X2JpbmFyeV9sb2NrX3Jv
KGhlYWRlcik7DQo+PiAwOGY2YzA1ZmViMWR+OmFyY2gveDg2L25ldC9icGZfaml0X2NvbXAzMi5j
Og0KPj4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhoZWFkZXIpOw0KPj4gMDhmNmMwNWZlYjFkfjpp
bmNsdWRlL2xpbnV4L2ZpbHRlci5oOnN0YXRpYyBpbmxpbmUgdm9pZA0KPj4gYnBmX2ppdF9iaW5h
cnlfbG9ja19ybyhzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKmhkcikNCj4+DQo+PiBUaGVyZWZv
cmUsIGNvbW1pdCAwOGY2YzA1ZmViMWQgc2hvdWxkIGhhdmUgaW5jbHVkZWQgYSBiYWNrcG9ydCBm
b3IgYXJtNjQuDQo+Pg0KPj4gU28geWVzLCBJIGFncmVlIHdpdGggR3JlZywgdGhlIGNvcnJlY3Qg
Zml4IHNob3VsZCBiZSB0byBiYWNrcG9ydCB0bw0KPj4gQVJNNjQgdGhlIGNoYW5nZXMgZG9uZSBv
biBvdGhlciBhcmNoaXRlY3R1cmVzIGluIG9yZGVyIHRvIHByb3Blcmx5DQo+PiBoYW5kbGUgcmV0
dXJuIG9mIHNldF9tZW1vcnlfcm94KCkgaW4gYnBmX2ppdF9iaW5hcnlfbG9ja19ybygpLg0KPg0K
PiBPaywgYnV0IGl0IGxvb2tzIGxpa2UgZHVlIHRvIHRoaXMgc2VyaWVzLCB0aGUgcG93ZXJwYyB0
cmVlIGlzIGNyYXNoaW5nDQo+IGF0IHRoZSBmaXJzdCBicGYgbG9hZCwgc28gc29tZXRoaW5nIHdl
bnQgd3JvbmcuICBMZXQgbWUgZ28gcmV2ZXJ0IHRoZXNlDQo+IDQgcGF0Y2hlcyBmb3Igbm93LCBh
bmQgdGhlbiBJIHdpbGwgYmUgZ2xhZCB0byBxdWV1ZSB0aGVtIHVwIGlmIHlvdSBjYW4NCj4gcHJv
dmlkZSBhIHdvcmtpbmcgc2VyaWVzIGZvciBhbGwgYXJjaGVzLg0KPg0KDQpGYWlyIGVub3VnaCwg
aW5kZWVkIEkgdGhpbmsgZm9yIHBvd2VycGMgaXQgcHJvYmFibHkgYWxzbyByZWxpZXMgb24gbW9y
ZQ0KY2hhbmdlcywgc28gYm90aCBBUk0gYW5kIFBPV0VSUEMgbmVlZCBhIGNhcmVmdWxsIGJhY2tw
b3J0Lg0KDQpJIGNhbiBsb29rIGF0IGl0LCBidXQgY2FuIHlvdSB0ZWxsIHdoeSBpdCB3YXMgZGVj
aWRlZCB0byBhcHBseSB0aGF0DQpjb21taXQgb24gc3RhYmxlIGF0IHRoZSBmaXJzdCBwbGFjZSA/
IElzIHRoZXJlIGEgcGFydGljdWxhciBuZWVkID8NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=

