Return-Path: <bpf+bounces-29625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD18C3B3C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 08:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF21C1F214D8
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 06:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696614659F;
	Mon, 13 May 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="d2/OwKbt"
X-Original-To: bpf@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021010.outbound.protection.outlook.com [52.101.167.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAC146596;
	Mon, 13 May 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581089; cv=fail; b=j1GQ3HfvmTE+TgLKwQoVBHlU+0DbXArC0BXrDjuZJJIZTIrrbb085V/U+m5d+px4RthuJzIDg4Hazji987mObQdrga6+VI+ZtrIrESBiqTF+g+9o/9wW+10wtB8dlmJ+sf6Py5VIDBuJEZJ3eabwDvs5eOvFwW/Tdm0+OVj/Mpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581089; c=relaxed/simple;
	bh=wAZKWFOinIYw4zfkchRfOTG+GXVOcrsvd2aXneRsHhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQyLx4nnpWZLPKbEPtl8xH6U2Pi0oZoZc9qX5rRTa7cpTsWhiR4NB/qpbL8kiT98zlz5Vw4ypZjIGEhKlLz1yLI3ys4tCJUfRELNEcrdRo52QqzJX2jXPxAJEMTHc6FzXCndYvvE2Nov+YsYhooax7hmHapKcLLRuz9wcvurEIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=d2/OwKbt; arc=fail smtp.client-ip=52.101.167.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBmyR1V5dCHRtMLMtHWm56kFrBtyfoPvtwVoxT6XKzAiEeO7nIBaUoexnZXMHsIkau361hpTwRFd2+0nrAaALbXU6gz4Gar9MUEFFrH9nL20tVkYNd8HAy8FQYtbchEmLuRTLcSV00HVVzezskmkoCED1rVREwp1QG6+cvlY3fauOb26qdNdlNDs8/LY6j2UAZsxpsfM6BJRuEaAwbS9d7bdlaEdQJQMmU+eMa1DVWSMjY+9mPNHXUBTfPCsE3sIr3teuY6TrDcEP10NQXNdtqT1T4VOwtH7f0T1L8aCcetJEBxwlfKPNuoMnMyocCygYkX9j41TsNbpSaVkVEvYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAZKWFOinIYw4zfkchRfOTG+GXVOcrsvd2aXneRsHhk=;
 b=O25SVbKo2its1D1Q4iPtqV9Dk3g8IN5m5UCigwPt95d28j4pjnBHpRieiCVgBHoi3fw8IGO8gm1SegrVw2QdPPZ4FI+aYwm9cDXjBLyVZH+u/ndCRpoE/GFnlmksGWIsx+7Zt/QmkvGPZ5x8LntdIOdfoUA+vLK/bZXgGUoFQ+VNJsQerfiSTixYJLb7zwK79pPe6vVXAjjetu6+iec621Q5z5I3BPYfgoqk467p6+dciq3oxIzbB9aY17T+KVtixiIdVgX2ghaaCl6D4X/KHrkkKWbc67tcnYBfLVm06Df/buaVpkmW07S7OMdPkDQ64hR+yYxnfRAHIthyn2AlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAZKWFOinIYw4zfkchRfOTG+GXVOcrsvd2aXneRsHhk=;
 b=d2/OwKbtIdnhnKE4f0mBpFpFCfYseRIcqM2vJgFQbbxphA+czSgRgAGryqfCrvycQldq2Y+hYqPStipWUl2ik29NfnJn6674CANCFRGDx48qRGJj1CySvg0648nvu/jOmrY8mUil5Ciju3SitLWZykfqd9wfhhTJU0vdCCa9GSaniKqGPIwIKKPK80q6I9CDyIrKX/E3hDnqO48zW/rBBt5G2fvLkCeE5wWOD0opT1HeCSjCgekHJD1NjVePA6SILPEL8nEOVnrFKkxH2a6S6U3zrOW32DAT5TbiEbwT6PldkUctqLnlnUuMDID58jRhowKiVsDuupEJGBw2N1DOHw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3207.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 06:18:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e6d7:9670:c147:b801]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e6d7:9670:c147:b801%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 06:18:04 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Hari
 Bathini <hbathini@linux.ibm.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>
CC: "puranjay12@gmail.com" <puranjay12@gmail.com>
Subject: Re: [PATCH bpf v2] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
Thread-Topic: [PATCH bpf v2] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
Thread-Index: AQHaoT5+jCvQEj7j7EevpLhDPR9oGLGUuCKA
Date: Mon, 13 May 2024 06:18:04 +0000
Message-ID: <73170d74-332c-45d4-883a-f4cda12f3542@csgroup.eu>
References: <20240508115404.74823-1-puranjay@kernel.org>
In-Reply-To: <20240508115404.74823-1-puranjay@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3207:EE_
x-ms-office365-filtering-correlation-id: f15f574d-db48-4680-86c5-08dc731472ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3JCdHRIZVMrR2Q5cjVURmI3T0dKU05UQmlWN0ZBZFJxMUZ5Mkl4WlIzd3Ji?=
 =?utf-8?B?SUk2Z0FTVHdYR2p1SkxlbFhTQU1IejFIVXFqM0dXVERySnVpYVVTdzBUOTBt?=
 =?utf-8?B?NW5SSSt1c1NmRWNjRnNpbGtHTmJiSmxpQ2svYzVIUjI5SHJTQU44WFBiZG9M?=
 =?utf-8?B?M25PdFRUWEcxY21qQ1oyTjJhVEJuL3pHVEFWTlRyclFsdlc3b2pQUnpZaWRF?=
 =?utf-8?B?Q2dud1YvQlhFclEwVVdRcWROUEdWeFAxSDQ2dGFmbElTdk4zaWtEMm94ek1m?=
 =?utf-8?B?cXRQS1lOckRIYXljVzdYREIxUUVpOFlGMXVzWEhINnBQdGwzSmF5QlpHcWNB?=
 =?utf-8?B?SXVHZHk2UW00eU1PQlc3TEVvK1Q2WVlvK2ZpRmRjK2tFNGtlRjZTWnIyZGxT?=
 =?utf-8?B?eGhaamdUc0FGVGZjUlNxOGIxK2NhSzI3clJyTUFJNHQ3MC9mYjF1V2FNNUgv?=
 =?utf-8?B?VGtjYk9nYWVJbFErTlYxQ3ZpZm41TGxmL2daQjgxVkVWQVI2U05MQ2l4TmQ2?=
 =?utf-8?B?bVowNStlMHdSVG8ydUF2QytwRkZ0WlB6YmNKREdzbTlDN2Y1bUxWRmRkRyts?=
 =?utf-8?B?R2NiM3B2dXdCZktyUnd3clRqN3c4d1ErU1JFcUMrNEFnNGZDQnNSU2FWMW5q?=
 =?utf-8?B?TVo5aHdCbE9NZWJQcU5RdmVGTmxIMDhSVGdBVURPbzAxVE1nZmNuQnBUSnYx?=
 =?utf-8?B?VW9RWitCR0dSMkNNcTFYVU4rYXlUeTNaakRZR09pQlhTMEkrcm12YXluNkxF?=
 =?utf-8?B?cThwd1RwZXo1ekN4Y2J6VWNlclRtWUFGd3FBbExvRG8veDZKTGViMjZaVTY4?=
 =?utf-8?B?TUZYWHpTOG1tUjJDODA3YTZkb3pmenk4VWlkOGVJTUJoTmYvY0FqclliOHps?=
 =?utf-8?B?dlpuNlVkU0FxNXBVMDkwZWttMGw5cG1ROSs1dThwdlYvSDJGdDVjV1R6WFMy?=
 =?utf-8?B?THE1TGxGUzEraWozaUhpRysxSThERFV1bkhrUEk4MDNORUpXbTgwNDk5dUJj?=
 =?utf-8?B?eXNjUUpUZkxacFVSZytPZXQ4elk5VVE5MXB6NVQ3SCtMSHJVZ0RIS3U3NGtQ?=
 =?utf-8?B?YXZ3QXNORlVhVXlaRUZhZnhCNW5WNXJiakRZYzRueFhxNTl3WDhjVmxsRUVU?=
 =?utf-8?B?NHBGZW0yb3lyOXo3SG81V0d5NElwM2dxbzRDcXJCQVBQQzdjMGdGYkJ1cTly?=
 =?utf-8?B?dFEwRUxsTUZMalNQdUNKNHZjdDJMQkkwcGhGREw0Nnk5L1lSVzJ3akZkUGNL?=
 =?utf-8?B?TlZIRUNKMHh0K2ZTM0k2U1VKTjgvVEU5QldnSFZmNHdXRUZ3c2ZRVFQwWDA4?=
 =?utf-8?B?bUhOZ3orbXlzM2ViRWptZVhyNW5aTUZ3TmUxTndxcVRwZjk2SXB5M0ZGME5t?=
 =?utf-8?B?ZXpXa29CSVhTdjRIOGh6RFZXM2gvMUpkS3JhNGJtMTZBbDlBWFRyWXQxaXMy?=
 =?utf-8?B?QXdmRlJmdFFPSkswalkwVSt3RDZJU3F5ZURyV3FsMzkxL3hWUVF2eHB6eTdq?=
 =?utf-8?B?dTFBbnRFUmpoa200UzJuUzJBbWRtMFB1aWJ1NTIwUllaMk91dU92V1pQTkw1?=
 =?utf-8?B?dDhVTXpPWENybjZ4b0hPWi9ZOVRmcndQZCt4L0JDYXhVN1p6bzJjTWJPQXRY?=
 =?utf-8?B?Mnk5UmIrdVU3UkViVU9iUGZMb1J5ZVpwbExPbTJhNGgyTVFiUkhCNkxhY2lh?=
 =?utf-8?B?c3I4ZTYvRGNCVDRMOWg3cXlvZHVQa3NyaXA2aVZwUWEwamlxcitDWDQ5WCtW?=
 =?utf-8?Q?brXu0fxjOBXXQ5nNjo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHhURkNROUI3RTVESVRSb2oxTnFWczJaVk90NmZJUWM1RGc0cjBzVWZ5ZFIy?=
 =?utf-8?B?U1J5ZlVMSWVtcXhrZUtpazNmVnFJSjkybkppMGNBY1RqcTBqZmc3MjZEMmo2?=
 =?utf-8?B?YkZJdzdBNjFObHgvVzlpZzFRdlN4d2VXSDM5NUFjQUNDV1R1VGFDVVBlK2Jh?=
 =?utf-8?B?bHIzVFZBbmxBN2FsMExGdjhrTEVpODZwNThVNUx1NE1YaWNqRnRXeEF0Vi9K?=
 =?utf-8?B?UlltYlNzMlBDZms4UDBpQmNPWmxYd2VmcThqUUVMVmJJV1ZMWDlnZmJMTStm?=
 =?utf-8?B?aFplZzBCVmJvOHBXK1pEaitKc08zS25lbjJobUt2WXlpWFlOajRnRVZEOXkz?=
 =?utf-8?B?TkVFbjJWaStIdENTVk1PTkxlSDRhTWlBSnhNMkZKYll4MWh4Qi81VWdVYjRB?=
 =?utf-8?B?UVd5blY2QzRlbWZzZE5nVDZISDB5YnU1MDg4ck9UUk56UndYenlZTE1FRDU5?=
 =?utf-8?B?T0NpNzVrRk9URWY3S0E3dzVYZzNMYTNuWWdHWlFXR3pYbVErRnhZYUp5QkFu?=
 =?utf-8?B?b213Y1FJTXlGb1BiNFpRY3Vxd2c3N0h6Y2xEOXB3QUlyTTVOTXowcDJVenhD?=
 =?utf-8?B?ekNORDJjRk8yaDY2N2dqNFVOM3V6YkhPNGhhQmlKRW85QnFGcXdKb3NVbncw?=
 =?utf-8?B?OUFaSHhpZWFHc0ZNODRWZC8wL0ZoMUR0U1ZzaS9CRVdJMndoSG5Na3VnRG85?=
 =?utf-8?B?aDBDVWN5MFd3QTlMclU3NUZSeDRIWXhTT3VJY213Z3lIWG4rNC9Lbzl5bHdz?=
 =?utf-8?B?NTAyQ0IzNkhGbytKNDdKUUtZdFlXbzAwcUplUitrMkR4dlg3c21xdkVaMVFw?=
 =?utf-8?B?K0YyUUVkU20xdmNSekR2S1VFYzVWdzJKRHVJRUdNdFJkQXRQQ0pvK1BrdndE?=
 =?utf-8?B?bTR0d0p3ZFkvbGkrL3AyaHBYNjEvbTlIQlhvVjJBaVYxOU5zY3Z1bzFTM0Z2?=
 =?utf-8?B?L3M1V09BenN1MDNKWVVzQUNDOVlXcEZZa0QveHd3TnRxS3A2WURkUzF0TWFh?=
 =?utf-8?B?THZzampTdUprcThlUko4VGc1RC9Bd2Q2UHhlNGV4ZHVEWG83VlBZRk1FVE9L?=
 =?utf-8?B?b2FWTDBkbVg3SnVtWlZhU2JMazBJLzR4S1V3YmlzWmNpZDF0QktCWWlHd3pV?=
 =?utf-8?B?M0JZYlgxMHlaTVIrMWo1VG1qNDl5cm5HMEorZWh6bWJ6NXJJZ0Y4YnNxa3pv?=
 =?utf-8?B?UXV1YTU5UWVJaGJlTTMyblFIZUdnczBGbndPazBGWnU0VThSbTBZK3JUS2FI?=
 =?utf-8?B?SzlSQUNSdGQvTTdkWjNRdlF0eWxmM2hiQkJnMHE5bVhUNHhuS3VCNnJkcVVG?=
 =?utf-8?B?L3FUdlVQeGpDcnR6REdrUXNpQkZwSks5TjBiNXJoZmhIaFk4QW1Id2J1aTRR?=
 =?utf-8?B?TEN5RHIyVFBiYTNGdEJ1Snl5ekl6NmJDcXkyc0JSV0hNd0ljbHV3T1ZLcG9i?=
 =?utf-8?B?S3NOZWYwMCtSY2dMemswczF1d0tncVZ4QU84QnBESi90OTFhSmZRNG1RM0hz?=
 =?utf-8?B?WE44YWpmcmF4aTdwajFYQnJ4U3BRd0xaVDR1SmZ3aHVLRGQwMldGSWNvYzYy?=
 =?utf-8?B?ajlzKzR3UG9tNDdITmJwMUNzdzM4NzladTNNWkk1b2twak9DVnM3aktlLzlt?=
 =?utf-8?B?KzY4dE55cTlxc0FuYlV2U29VTUx4ckVnYWxVdklXRmxTM2lmb0pTSFRGc3lD?=
 =?utf-8?B?YXZia1BvdTh1VlpIN3RLSi8vamRwaFNrRnErZXJMYi84czdDNitVVFZGdE8w?=
 =?utf-8?B?Y3EwVXBaeUtVRGJDeHBVQTEwdzk2YnBmOWQ4WlBqYXhRN0ZLaWRMYzJ4U0RC?=
 =?utf-8?B?aTRDbDQwMTQ3RGtsR3BzYUZUdE9WTThsZnpldVltbTJqTlpjbFhSdWJjRXd1?=
 =?utf-8?B?bDJHZjVKT2RJL1RzWHJxWWZLN0lJNkl6RWJkSjFCY1hMZTVhWXZtUHpGR25R?=
 =?utf-8?B?MjF5bDdFaHdJdDR5YlNnRFRzOFRIL085K2l0NkRpUkR0ZkJkQXpXcU5ZbXJl?=
 =?utf-8?B?TmVzWEhQU3NMeDk0SFV1aDZEVU1CRkxRaHVUQVRTMm00RzRBTG1Xdko3bC9p?=
 =?utf-8?B?aHZ1MHdQWldmdXA2OE9SUkRxS1JNR3VPRlNOUW1lRFdjT2ptZjJ1YnFoQ3cz?=
 =?utf-8?Q?JfbvDphXPb90OTJTrHytuI4XB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23466EAF86301642B50E90438010B6EC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f15f574d-db48-4680-86c5-08dc731472ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 06:18:04.2145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9e0uhHbmsEiuJUJlszf+jKiEY0mkcn1WO3J8A0Gpvs9l1Jh2FpNpzeVFtdvByV/lKO+3Ti06TgYqoLw6yBGntuIj6jJzC3Fl+N1vnra81GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3207

DQoNCkxlIDA4LzA1LzIwMjQgw6AgMTM6NTQsIFB1cmFuamF5IE1vaGFuIGEgw6ljcml0wqA6DQo+
IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIHB1cmFuamF5QGtl
cm5lbC5vcmcuIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgIGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBUaGUgTGlu
dXggS2VybmVsIE1lbW9yeSBNb2RlbCBbMV1bMl0gcmVxdWlyZXMgUk1XIG9wZXJhdGlvbnMgdGhh
dCBoYXZlIGENCj4gcmV0dXJuIHZhbHVlIHRvIGJlIGZ1bGx5IG9yZGVyZWQuDQo+IA0KPiBCUEYg
YXRvbWljIG9wZXJhdGlvbnMgd2l0aCBCUEZfRkVUQ0ggKGluY2x1ZGluZyBCUEZfWENIRyBhbmQN
Cj4gQlBGX0NNUFhDSEcpIHJldHVybiBhIHZhbHVlIGJhY2sgc28gdGhleSBuZWVkIHRvIGJlIEpJ
VGVkIHRvIGZ1bGx5DQo+IG9yZGVyZWQgb3BlcmF0aW9ucy4gUE9XRVJQQyBjdXJyZW50bHkgZW1p
dHMgcmVsYXhlZCBvcGVyYXRpb25zIGZvcg0KPiB0aGVzZS4NCj4gDQo+IFdlIGNhbiBzaG93IHRo
aXMgYnkgcnVubmluZyB0aGUgZm9sbG93aW5nIGxpdG11cy10ZXN0Og0KPiANCj4gUFBDIFNCK2F0
b21pY19hZGQrZmV0Y2gNCj4gDQo+IHsNCj4gMDpyMD14OyAgKCogZHN0IHJlZyBhc3N1bWluZyBv
ZmZzZXQgaXMgMCAqKQ0KPiAwOnIxPTI7ICAoKiBzcmMgcmVnICopDQo+IDA6cjI9MTsNCj4gMDpy
ND15OyAgKCogUDAgd3JpdGVzIHRvIHRoaXMsIFAxIHJlYWRzIHRoaXMgKikNCj4gMDpyNT16OyAg
KCogUDEgd3JpdGVzIHRvIHRoaXMsIFAwIHJlYWRzIHRoaXMgKikNCj4gMDpyNj0wOw0KPiANCj4g
MTpyMj0xOw0KPiAxOnI0PXk7DQo+IDE6cjU9ejsNCj4gfQ0KPiANCj4gUDAgICAgICAgICAgICAg
ICAgICAgICAgfCBQMSAgICAgICAgICAgIDsNCj4gc3R3ICAgICAgICAgcjIsIDAocjQpICAgfCBz
dHcgIHIyLDAocjUpIDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
ICA7DQo+IGxvb3A6bHdhcnggIHIzLCByNiwgcjAgIHwgICAgICAgICAgICAgICA7DQo+IG1yICAg
ICAgICAgIHI4LCByMyAgICAgIHwgICAgICAgICAgICAgICA7DQo+IGFkZCAgICAgICAgIHIzLCBy
MywgcjEgIHwgc3luYyAgICAgICAgICA7DQo+IHN0d2N4LiAgICAgIHIzLCByNiwgcjAgIHwgICAg
ICAgICAgICAgICA7DQo+IGJuZSAgICAgICAgIGxvb3AgICAgICAgIHwgICAgICAgICAgICAgICA7
DQo+IG1yICAgICAgICAgIHIxLCByOCAgICAgIHwgICAgICAgICAgICAgICA7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgOw0KPiBsd2EgICAgICAgICByNywgMChy
NSkgICB8IGx3YSAgcjcsMChyNCkgOw0KPiANCj4gfmV4aXN0cygwOnI3PTAgL1wgMTpyNz0wKQ0K
PiANCj4gV2l0bmVzc2VzDQo+IFBvc2l0aXZlOiA5IE5lZ2F0aXZlOiAzDQo+IENvbmRpdGlvbiB+
ZXhpc3RzICgwOnI3PTAgL1wgMTpyNz0wKQ0KPiBPYnNlcnZhdGlvbiBTQithdG9taWNfYWRkK2Zl
dGNoIFNvbWV0aW1lcyAzIDkNCj4gDQo+IFRoaXMgdGVzdCBzaG93cyB0aGF0IHRoZSBvbGRlciBz
dG9yZSBpbiBQMCBpcyByZW9yZGVyZWQgd2l0aCBhIG5ld2VyDQo+IGxvYWQgdG8gYSBkaWZmZXJl
bnQgYWRkcmVzcy4gQWx0aG91Z2ggdGhlcmUgaXMgYSBSTVcgb3BlcmF0aW9uIHdpdGgNCj4gZmV0
Y2ggYmV0d2VlbiB0aGVtLiBBZGRpbmcgYSBzeW5jIGJlZm9yZSBhbmQgYWZ0ZXIgUk1XIGZpeGVz
IHRoZSBpc3N1ZToNCj4gDQo+IFdpdG5lc3Nlcw0KPiBQb3NpdGl2ZTogOSBOZWdhdGl2ZTogMA0K
PiBDb25kaXRpb24gfmV4aXN0cyAoMDpyNz0wIC9cIDE6cjc9MCkNCj4gT2JzZXJ2YXRpb24gU0Ir
YXRvbWljX2FkZCtmZXRjaCBOZXZlciAwIDkNCj4gDQo+IFsxXSBodHRwczovL3d3dy5rZXJuZWwu
b3JnL2RvYy9Eb2N1bWVudGF0aW9uL21lbW9yeS1iYXJyaWVycy50eHQNCj4gWzJdIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vYXRvbWljX3QudHh0DQo+IA0KPiBGaXhl
czogNjUxMTI3MDkxMTVmICgicG93ZXJwYy9icGYvNjQ6IGFkZCBzdXBwb3J0IGZvciBCUEZfQVRP
TUlDIGJpdHdpc2Ugb3BlcmF0aW9ucyIpDQo+IFNpZ25lZC1vZmYtYnk6IFB1cmFuamF5IE1vaGFu
IDxwdXJhbmpheUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MSAtPiB2MjoNCj4g
djE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDUwNzE3NTQzOS4xMTk0NjctMS1w
dXJhbmpheUBrZXJuZWwub3JnLw0KPiAtIERvbid0IGVtaXQgYHN5bmNgIGZvciBub24tU01QIGtl
cm5lbHMgYXMgdGhhdCBhZGRzIHVuZXNzZW50aWFsIG92ZXJoZWFkLg0KPiAtLS0NCj4gICBhcmNo
L3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcDMyLmMgfCAxMiArKysrKysrKysrKysNCj4gICBhcmNo
L3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcDY0LmMgfCAxMiArKysrKysrKysrKysNCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bv
d2VycGMvbmV0L2JwZl9qaXRfY29tcDMyLmMgYi9hcmNoL3Bvd2VycGMvbmV0L2JwZl9qaXRfY29t
cDMyLmMNCj4gaW5kZXggMmYzOWM1MGNhNzI5Li4wMzE4YjgzZjJlNmEgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wMzIuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMv
bmV0L2JwZl9qaXRfY29tcDMyLmMNCj4gQEAgLTg1Myw2ICs4NTMsMTUgQEAgaW50IGJwZl9qaXRf
YnVpbGRfYm9keShzdHJ1Y3QgYnBmX3Byb2cgKmZwLCB1MzIgKmltYWdlLCB1MzIgKmZpbWFnZSwg
c3RydWN0IGNvZGUNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIC8qIEdldCBvZmZzZXQgaW50
byBUTVBfUkVHICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBFTUlUKFBQQ19SQVdfTEko
dG1wX3JlZywgb2ZmKSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB0bXBfaWR4ID0gY3R4
LT5pZHggKiA0Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgKiBFbmZvcmNlIGZ1bGwgb3JkZXJpbmcgZm9yIG9wZXJhdGlvbnMgd2l0aCBC
UEZfRkVUQ0ggYnkgZW1pdHRpbmcgYSAnc3luYycNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICogYmVmb3JlIGFuZCBhZnRlciB0aGUgb3BlcmF0aW9uLg0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgKg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBUaGlzIGlzIGEgcmVxdWlyZW1l
bnQgaW4gdGhlIExpbnV4IEtlcm5lbCBNZW1vcnkgTW9kZWwuDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAqIFNlZSBfX2NtcHhjaGdfdTY0KCkgaW4gYXNtL2NtcHhjaGcuaCBhcyBhbiBleGFt
cGxlLg0KDQpZb3UgbWVhbiBfX2NtcHhjaGdfdTMyKCkgPw0KDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaW1tICYgQlBGX0ZFVENI
ICYmIElTX0VOQUJMRUQoQ09ORklHX1NNUCkpDQoNClBsZWFzZSBlbmNsb3NlIGltbSAmIEJQRl9G
RVRDSCBpbnNpZGUgYSAoKSB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRU1JVChQUENfUkFXX1NZTkMoKSk7DQoNCkRvIHlvdSByZWFs
bHkgd2FudCB0byBkbyBpdCBpbnNpZGUgdGhlIGxvb3AgYXQgZWFjaCB0cnkgPyBCZWNhdXNlIHdo
ZW4gDQpzdHdjeC4gZmFpbHMgaXQganVtcHMgYmFjayBhdCB0bXBfaWR4IHdoaWNoIGlzIHlvdXIg
bmV3IHN5bmMgbm93Lg0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBsb2FkIHZhbHVl
IGZyb20gbWVtb3J5IGludG8gcjAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEVNSVQo
UFBDX1JBV19MV0FSWChfUjAsIHRtcF9yZWcsIGRzdF9yZWcsIDApKTsNCj4gDQo+IEBAIC05MDUs
NiArOTE0LDkgQEAgaW50IGJwZl9qaXRfYnVpbGRfYm9keShzdHJ1Y3QgYnBmX3Byb2cgKmZwLCB1
MzIgKmltYWdlLCB1MzIgKmZpbWFnZSwgc3RydWN0IGNvZGUNCj4gDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiBGb3IgdGhlIEJQRl9GRVRDSCB2YXJpYW50LCBnZXQgb2xkIGRhdGEgaW50
byBzcmNfcmVnICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoaW1tICYgQlBGX0ZF
VENIKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogRW1pdCAnc3luYycg
dG8gZW5mb3JjZSBmdWxsIG9yZGVyaW5nICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1NNUCkpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFTUlUKFBQQ19SQVdfU1lOQygpKTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRU1JVChQUENfUkFXX01SKHJldF9yZWcsIGF4X3JlZykpOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWZwLT5hdXgtPnZlcmlmaWVy
X3pleHQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRU1JVChQ
UENfUkFXX0xJKHJldF9yZWcgLSAxLCAwKSk7IC8qIGhpZ2hlciAzMi1iaXQgKi8NCj4gZGlmZiAt
LWdpdCBhL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wNjQuYyBiL2FyY2gvcG93ZXJwYy9u
ZXQvYnBmX2ppdF9jb21wNjQuYw0KPiBpbmRleCA3OWYyMzk3NGEzMjAuLjlhMDc3ZjhhY2Y3YiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL25ldC9icGZfaml0X2NvbXA2NC5jDQo+ICsrKyBi
L2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wNjQuYw0KPiBAQCAtODA0LDYgKzgwNCwxNSBA
QCBpbnQgYnBmX2ppdF9idWlsZF9ib2R5KHN0cnVjdCBicGZfcHJvZyAqZnAsIHUzMiAqaW1hZ2Us
IHUzMiAqZmltYWdlLCBzdHJ1Y3QgY29kZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgLyog
R2V0IG9mZnNldCBpbnRvIFRNUF9SRUdfMSAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
RU1JVChQUENfUkFXX0xJKHRtcDFfcmVnLCBvZmYpKTsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHRtcF9pZHggPSBjdHgtPmlkeCAqIDQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIC8q
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIEVuZm9yY2UgZnVsbCBvcmRlcmluZyBmb3Ig
b3BlcmF0aW9ucyB3aXRoIEJQRl9GRVRDSCBieSBlbWl0dGluZyBhICdzeW5jJw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgKiBiZWZvcmUgYW5kIGFmdGVyIHRoZSBvcGVyYXRpb24uDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAqDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIFRo
aXMgaXMgYSByZXF1aXJlbWVudCBpbiB0aGUgTGludXggS2VybmVsIE1lbW9yeSBNb2RlbC4NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICogU2VlIF9fY21weGNoZ191NjQoKSBpbiBhc20vY21w
eGNoZy5oIGFzIGFuIGV4YW1wbGUuDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoaW1tICYgQlBGX0ZFVENIICYmIElTX0VOQUJMRUQo
Q09ORklHX1NNUCkpDQoNClBsZWFzZSBlbmNsb3NlIGltbSAmIEJQRl9GRVRDSCBpbnNpZGUgYSAo
KSB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0KDQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFTUlUKFBQQ19SQVdfU1lOQygpKTsNCg0KU2FtZSwgdGhlIHN5bmMgc2hvdWxkIGJl
IG91dHNpZGUgdGhlIGxvb3AgSSBndWVzcy4NCg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
LyogbG9hZCB2YWx1ZSBmcm9tIG1lbW9yeSBpbnRvIFRNUF9SRUdfMiAqLw0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHNpemUgPT0gQlBGX0RXKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFTUlUKFBQQ19SQVdfTERBUlgodG1wMl9yZWcsIHRtcDFfcmVnLCBkc3Rf
cmVnLCAwKSk7DQo+IEBAIC04NjUsNiArODc0LDkgQEAgaW50IGJwZl9qaXRfYnVpbGRfYm9keShz
dHJ1Y3QgYnBmX3Byb2cgKmZwLCB1MzIgKmltYWdlLCB1MzIgKmZpbWFnZSwgc3RydWN0IGNvZGUN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIFBQQ19CQ0NfU0hPUlQoQ09ORF9ORSwgdG1wX2lk
eCk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGltbSAmIEJQRl9GRVRDSCkg
ew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIEVtaXQgJ3N5bmMnIHRvIGVu
Zm9yY2UgZnVsbCBvcmRlcmluZyAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChJU19FTkFCTEVEKENPTkZJR19TTVApKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRU1JVChQUENfUkFXX1NZTkMoKSk7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEVNSVQoUFBDX1JBV19NUihyZXRfcmVnLCBfUjApKTsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICogU2tpcCB1bm5lY2Vzc2FyeSB6ZXJvLWV4dGVuc2lvbiBmb3IgMzItYml0IGNt
cHhjaGcuDQo+IC0tDQo+IDIuNDIuMA0KPiANCg==

