Return-Path: <bpf+bounces-47278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4369F6FE0
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF1F16CD92
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4EC1FCCEE;
	Wed, 18 Dec 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GxQ/vec6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2191A9B4A;
	Wed, 18 Dec 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559852; cv=fail; b=IJHBcJmO7gzoEIcie6G0e9K1weouDzaElsppTifc2v8dFnwZyn2tjC/wxZ0+1QDrNlbMYey4E6ZquyLdWKryzT4X+oxE1aewqTX/ZOEcm/Hm7UHP/gKzm362X80E1Q1wunjc3KB/+RJ663ghJ2AhatNSf95yaXCspzJiHwSRPWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559852; c=relaxed/simple;
	bh=wHfd7gnzCXRnIcHoyj7CfDDtuueRwsx3YA4+eIZmzEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LG4npD++9rkSXAvseLoZg3P2HFbMcFxOZdARTh+fcTWl39xRCteZQvLXIs+G4JdJCoCKDP5PveeMlI72Yy8ZJ7BCpDIaKeMCBNchpgUgQEK99uKH8OEQHDLvvbaAe52dTNtjlPzh6/mW8FHOMUSL1BIFjYH4QBBuTW2ro8KqUPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GxQ/vec6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BILp8iT013802;
	Wed, 18 Dec 2024 14:10:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=wHfd7gnzCXRnIcHoyj7CfDDtuueRwsx3YA4+eIZmzEk=; b=
	GxQ/vec6QM+Vzj/YiL7OC+dYToZtrV6qwEVmvy/RB3qO2qAyULSni5/yPNvOsxOI
	4gDjme5IvYZBM26uAcNfqVQE0CjHkuvFy0/2hTozWA0cBsnUFTcMYm5FQbxC6GWx
	XJNTDDmknTjK4x1RZWXzDop9icPdQD5uqijmfRZSbEEFl0aTK/JvN6LRalO9oBO0
	Gzuwq1pAObMDYcsnfaIb9hQAB9hQEVa28xlhVhM27aiFB+tON8FpdD49LdSKhs3D
	1/yNGrlnmTS8nXylH86uqBStYvLJwqO8DF4jKlkZBmmlcLAaKGJhXHd2Ec/P3AmA
	OEd/ivIHnODW9hODTk51Eg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43m3yksce5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 14:10:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeJhrdWjEnaLT4YYyyliCZrKk803b6zXMDNLG4INp2/Q1DKtMBzWN+YgVw4MVlzPbyiRStwNzH7tEsd783oQBT9SLXBe2oLGXnV4IUOLk6Ic2fOtZzLkI2Vlec+BH5bF/CrXZpOWMIEjzsVYBFIabUgiwJLsgA6K59eEqJTpdyHoUkYhv+2mwdJYMvtUI9Pdw7kWrQCtOJq8C0tK5c8CQ1TtLWeG9rX6dmzoYu94XXAw7r0rKIv30UWtNWxa0Sw9jba42PD1GTz74SZx0ISSOKm0rOlyBAQ6VNI/FmmYoZUDlGBjqVGWTW/aTog34uEC/fnViS9mbvfiRHHN3vfYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHfd7gnzCXRnIcHoyj7CfDDtuueRwsx3YA4+eIZmzEk=;
 b=rQPo+IaRv3OUJ87+71MGIw9/yjf/J4dya5wag8jK4XzD0kM2pin4D28IRQoBuRH2orNb6G2IbPLEnayi2I8HtThT/5VQNXbB2j5NWku9ag0kXcbvMgr3nXcYjq5a7foG+pQHe+evjNL1rYEuyw8sCoMQEJicGWKrnGpl1CiqSh/5Z42m4gHPuDGv44nQZtYs30keqoWWBdE0lvUnYURGr1cTSiwrWBLEpEcBw6vFBnFaCiUAtLTwk5Y1QCGvgyARe9ZYXIOyAvKnM90qC6ycNSNZ4y9hbPu1Vv18hoEUc4SYoYZ9kJfVRgLXMnm3WdSOf1uSDPEO2iGCocFmKBiylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6237.namprd15.prod.outlook.com (2603:10b6:610:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 22:10:47 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 22:10:47 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <songliubraving@meta.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu
	<song@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v5 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbUQgH26q3Z2MAsEyHPIKkiJbGP7Lsg1AAgAAHd4CAAAZ8AA==
Date: Wed, 18 Dec 2024 22:10:46 +0000
Message-ID: <14610672-A596-4920-B15E-015506A1E3A1@fb.com>
References: <20241218044711.1723221-1-song@kernel.org>
 <20241218044711.1723221-5-song@kernel.org>
 <CAADnVQK2chjFr8EwpzbnsqLwGRfoxjRs6yXDXmUuBRFo-iwV_A@mail.gmail.com>
 <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
In-Reply-To: <BF2BF0EC-90C2-4BFC-B1F3-D842AE1B7761@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6237:EE_
x-ms-office365-filtering-correlation-id: 68df0e97-1bc4-41b4-e657-08dd1fb0d2ef
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjZFQ1phLzdlbjZLVk0yVGZ2cVZXblJld214UWNRWWN2WnJ5dEUyZHlwV2Jk?=
 =?utf-8?B?N2h1eFRyR25mM0hYckdZM3hWVTIzZ3hIRmQyQ0J1Mlh0YmJNeStha2V2VlVm?=
 =?utf-8?B?N3l5Zmg2S201dis2WUhYTEFxbUt3bmZBYWxJV2ZKcHRvL3hLYStoRkdzTXJu?=
 =?utf-8?B?NlpsZWhBczFObVRlaHNhakJ5OUpwSnovN1BHK3IyTjhacnJ5OWpzMlNsdUF0?=
 =?utf-8?B?RUwwNHVzUExlb1gwYS90dE0ySzhJRTdSOVo1LzRieGRCeGtacU9jdHZrV2Zr?=
 =?utf-8?B?ZW8vOHZFaC94OTEyMDdMUDU0bDJZYkQ0K0hpdm1YOU96QXpQUVhFKzRJbkpZ?=
 =?utf-8?B?VE50MmVaaXk4QjdvY2pMdHNFbjVTMHRvYzVPODZUMStPVDZpK1VIWDhRaWZO?=
 =?utf-8?B?ZitWTW5nKzFITUVidmlaSkxCS1MwYnlNK2xmTHZadmlleXlGMWRwclo0ZG9v?=
 =?utf-8?B?OExnMmhpMHM5UW1WaGZDTWdlelV4TVcwMEJENkNmbk54cDdoSS9SN3RtR3VK?=
 =?utf-8?B?T20wWVFNZUx5REk3NXhFRjFtNFo0WlNPRGIrenE0by8wekVrSzFkUlJsc2w1?=
 =?utf-8?B?d2JOcjNDQ0hUcDhiNHkramZ0b05IUUpzeHcyOUlVOXRWVFZNbDZPSVhZcS93?=
 =?utf-8?B?ZjhWc1YzaUZnQVhobGlia0t2UGl5cmNXRlNyWStYUWNOVjR2R2JsM3l6c0JB?=
 =?utf-8?B?akUwd0hyZ0hnZVhCOEU5VmN0Ukh1dlBQT0lSTHBHVjBCclIxcEpaSTNhUmRF?=
 =?utf-8?B?bWxLZXlNRG9TNUdGR3RDN1Fod3RmVmVpWTUvRzl4aVdic3FVWHhPMy8rMms3?=
 =?utf-8?B?MkhqckU5bE5mQngzM081M3E2V1hTYUZ2N2ZwMUN1S2xkb3lpQWFaMkNtT3FR?=
 =?utf-8?B?WUh3aks2SThPL3FhSHgvRkVDSHlJbEV0UFVYNmdwQitodVZtRHpubWI3cVNO?=
 =?utf-8?B?M3dLZTBkRjBjWFVIWHhCWkFGUzZCUkJpUU96SkxtVnpuZk1MUzNNRDRrdkNR?=
 =?utf-8?B?c2NSSjk4cnhaNmx5cGZXUnFkcVQ1UTROTmMweEh5dytFQWdCQUtZMDByYTZQ?=
 =?utf-8?B?amtDYkRlRC9aQ2pWSUd3SkVqK04vNFdtRjBCYkZWVXB1c2NGQSszTjRlT3dT?=
 =?utf-8?B?Y2VnSkxBdzRsVFl3RjV6eklkc09QbW9TTEVjZytZTS9xb2pGbzJtNXJUUFJr?=
 =?utf-8?B?WmRzL0RGWlhhUzZic29XL1ZlZTVYckhaQUpXU1NiWUNkRnE1RFdEcjVOSVRt?=
 =?utf-8?B?d3hTaGt5ekRXMzRpZVpYVTg4SGN4YU1JbzdWNFZMVndadlJkQ1k5cmNjQkwx?=
 =?utf-8?B?Mi94elF3SVhjU1RWUHhiait1U0djQWtQa0lST1V6R0ovTmJDaWhJWWs3Wm9O?=
 =?utf-8?B?cVdCa2s3eldnTUJ1V3Ntd1NQMExiM0JyeEJOZ3BtNEZLajh0SEQycVJvVTJB?=
 =?utf-8?B?L1ZOeUJha1pob0R2dmdNZzZHYnVjL2NqVUlvVzNQdE1YVEZCVTcyUDNCSmFp?=
 =?utf-8?B?UnNUdXZlUXFiUnZPQTZ6c0pnd1hsdU1SZ2JiUjRVL3RNVmNUVFRwbEtyL0NC?=
 =?utf-8?B?Wk1mOGtLTDJtdXhvNERlbFl1blNpZ2dTckIzb0QzbFgyRnJpSWZOaG9lSUJS?=
 =?utf-8?B?NDk1Q0NBREFUcUlVWWJNWkx1aXNMQUJqeDI2ZmxKei95dVRrWTFrcUw3b2xy?=
 =?utf-8?B?U3BHNDE2ZittSWJDQmIvMEExNXdoUmN1Sk9hUHBQN3RkcjUwQjhKNEhxM3BU?=
 =?utf-8?B?dUg1K2xlSzBGd1d3WjhpeTNiREo0VGYyVVVMT203bGVLUlp1azFaV2pTenJn?=
 =?utf-8?B?ZEFHTE5RK0ZsT1MyaStpNnBEa1BhWHEyUjFIa3QxSy92SGFJZi9OZDhDRnZD?=
 =?utf-8?B?bTYzMVNMaEVxckV5VmQwNjVaai91QmRJODE1OFpHTm9KT1d1SDQrdDdHNGZE?=
 =?utf-8?Q?OxKPu0Eloy/AzDIr/yagru8xB7Ozze3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHRyZm80aXhzUjdNL2pjVnY2cVM1dlJkM2tpbjFTaURkbGlpWkEvVkt2TUdo?=
 =?utf-8?B?cGxoODBZWGI1NGdXeFN0SzhMREl0YWdERVBCS1owbExTL21VMVBhWitqZ0hC?=
 =?utf-8?B?K1ovalQ5M1VlaTNmZ1lKMHoxenU1dVNvOGJIRzNsMnJITDdXcVF2NGdVV0tW?=
 =?utf-8?B?R0JGUjBEbjR0R2U0dVpVZ2NYSGViaGR5b0JmVHpLM1Z1Sm1UbEUzdXdtSXhS?=
 =?utf-8?B?UlN5SGlSa2xOYnVYNHF2ZTQ2Vk1oVjkxY2RGODZVV21HKzB3enBEZC9QNUw3?=
 =?utf-8?B?WGJqYU1FYWthUjc3T205QVFnR2xoMDRwbXk2Q3pJb0VDTU9hQVdQU1oweFpR?=
 =?utf-8?B?QlQwU1hrS1FwQXNGWUpmNUdsamttWmNpbkY4dzZZTHc0WTNtcUZGT2lWcDkr?=
 =?utf-8?B?SndRc3FVa0liMWxYeXNtS3JTbDlJcU9OOHdmWnhuWE0zaHEzMkhIRlNQRUNM?=
 =?utf-8?B?SE1IYWxwb0p2eDZQakYrNUh3U3VBU2p4aVhuN1ZHcFBmTEFocXBEaGdmOTNV?=
 =?utf-8?B?QXJtNmVYekM5V2dRS1QwQ2hoa04xbWRGVEEyc1JCeTdsaE1kU1NMMWJqeEll?=
 =?utf-8?B?WGNIeHVacGY0WjZ6bHp4NjNIRjV2ZWRuR2dXNmRwd2dIZ0lRRHd6MkdkRXhJ?=
 =?utf-8?B?dDY4WmQ0U3A3QXJmNktlektoYk9pS1NxaHBiWXI5SnRSN0h5M2JTcENrbTRZ?=
 =?utf-8?B?MUQ3M0wweVNmRS9SbXpwd3QwdE5tK2k2QlNRa0o3TVYzaW1yek95bGo4c2hT?=
 =?utf-8?B?NmJWMGxrZWdPSnBmTEtVQTdvRzdqOUdQeUJ2VEZzVzRSUnB5L2NnVGsrSm5H?=
 =?utf-8?B?eTV4Q3B3SVFaK21hT1ArK2RvNk9sSGNyRERHR2k4dmJxY0xrSHZHSVhGdkRL?=
 =?utf-8?B?MTAxNlVnTEFpNHhtcnhNcTRKR0hwejIyTkpaT2pGeVZuSVpIa0ttVnYzVS9Z?=
 =?utf-8?B?c2xZQjQycGdkWTRYUC9FTFNjTDJlejlZYnV2YjRnYUpuT3RsSi9EZjNYdFZ4?=
 =?utf-8?B?S2FFdmVSQmRXTTZobmMvTkJnZjFwSFM0TXduNWR1YXdjTlB0alB0N0hDWnpJ?=
 =?utf-8?B?SFE0NWFtUnpkODVIYWNJTmtnUDk5MEg2SGJhUk1ScjIybjY0Wlc0bTdUZGdE?=
 =?utf-8?B?WVVDc0Y2TXlDU096d0hYOUgzOTNRdUpYNzllRFNDWXI5a3Z2UExMWGVweTBN?=
 =?utf-8?B?aERVR0tzWWwxYUE2U1pyRDFYTEZKaGF2bnozdkFwdnVMTTNiYi9DN0FTZ3dn?=
 =?utf-8?B?elA3bytGbW5BSWc0MERaampwT2orL1I2d1pjTXBYWHIxRDBzbEFiSlFjQjRh?=
 =?utf-8?B?QXVQVXlBYVd1YkxVcVJIQXNiRGh1cXB4cC9CZHo4QjArUFpDNnZpTmsrcHJ4?=
 =?utf-8?B?Z3VXbkN2R2ZZOU0wVjViVE4vcXRyaWV0V2xFcFEwZ0VNTVdDSDRTa1BuZUI5?=
 =?utf-8?B?V0xONHVkTnZnYmlYT25sUlkyNlZDZnVXNkFpVStCMDFQelRkZFJKTWpIRkJP?=
 =?utf-8?B?REVGZ2xjcExQSjk3aXI3OURrWEt4aUdYUnREN1ByR0tjdFRiNkpPWGgwdkUz?=
 =?utf-8?B?UFNPRTB0ZmxldW15WUl0aGE2c1N6TlNuK1pYWEljbG9JcHl4NDF6L3ZHb2Nl?=
 =?utf-8?B?V1V1TjNlWnIwZXRTY1JMNDNTNHpCWGpFSTJuVnlXZUR6NnFrenJkVHRkSW51?=
 =?utf-8?B?MVRKWnltWTkzbUgxQzN2aUR3RlNhdnY5RHdoNlMvUk95LzJHTlhnSHN2U0l5?=
 =?utf-8?B?b0txbVIvbE13T3FwZ0plRklBNmdzbTNYZitOSjVBRmx2SHdaek9ZckJEOXdZ?=
 =?utf-8?B?a0FldmRzSHF4QnB6bTdiWjQvRkp3eW9KQlZiRTk5TzFtbnZLTGdWR3VPUnBo?=
 =?utf-8?B?N01sNnk4Rmtyb051Q1FkZk1iYUc2d3BXdG9leldkZWkxdEJzdU85K2hmUmFv?=
 =?utf-8?B?VmkwYXc0TlFVRncyNWk0WFRJbUZ0U0ErNm94QWpadXhvSUVIcXBDSzVIZkh1?=
 =?utf-8?B?Q25FZ1NZSUQ4aWtMc0RKZHVHRDRoSFNOblZaRWtPdytaY0pyNVN2SzRFblZR?=
 =?utf-8?B?bDFaWmhETmhvNXNtT3ZhcWVNVWc4M2FKekxDbXphd2RkN1JiT21yc2tYc1hR?=
 =?utf-8?B?YTRIaDEzSXltL0hGMDFjcEVvQkQzY014VkIwMHpEYUlPZit1Qi9ueHJUODBU?=
 =?utf-8?Q?Kvh80d7brfBi6nOGwkQt5EE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA1F2AD9FF7BBE48A6EA14B20B3321B2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df0e97-1bc4-41b4-e657-08dd1fb0d2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 22:10:46.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kgAZa/PIKfdlxwFTfiEPwaEb9F6u9TxBkZh2yMCK7ZerPSDFsvfnVYirZQKCWiagoesXN7LSrPUlefDkrcKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6237
X-Proofpoint-GUID: Bp_2yrr1qif1AqzkFs9AwELDQLdzO6AA
X-Proofpoint-ORIG-GUID: Bp_2yrr1qif1AqzkFs9AwELDQLdzO6AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE4LCAyMDI0LCBhdCAxOjQ34oCvUE0sIFNvbmcgTGl1IDxzb25nbGl1YnJh
dmluZ0BtZXRhLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBBbGV4ZWksIA0KPiANCj4gVGhhbmtzIGZv
ciB0aGUgcmV2aWV3IQ0KPiANCj4+IE9uIERlYyAxOCwgMjAyNCwgYXQgMToyMOKAr1BNLCBBbGV4
ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4g
DQo+PiBPbiBUdWUsIERlYyAxNywgMjAyNCBhdCA4OjQ44oCvUE0gU29uZyBMaXUgPHNvbmdAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gQlRGX0tGVU5DU19TVEFSVChicGZfZnNf
a2Z1bmNfc2V0X2lkcykNCj4+PiBAQCAtMTcwLDYgKzMzMCwxMCBAQCBCVEZfSURfRkxBR1MoZnVu
YywgYnBmX3B1dF9maWxlLCBLRl9SRUxFQVNFKQ0KPj4+IEJURl9JRF9GTEFHUyhmdW5jLCBicGZf
cGF0aF9kX3BhdGgsIEtGX1RSVVNURURfQVJHUykNCj4+PiBCVEZfSURfRkxBR1MoZnVuYywgYnBm
X2dldF9kZW50cnlfeGF0dHIsIEtGX1NMRUVQQUJMRSB8IEtGX1RSVVNURURfQVJHUykNCj4+PiBC
VEZfSURfRkxBR1MoZnVuYywgYnBmX2dldF9maWxlX3hhdHRyLCBLRl9TTEVFUEFCTEUgfCBLRl9U
UlVTVEVEX0FSR1MpDQo+Pj4gK0JURl9JRF9GTEFHUyhmdW5jLCBicGZfc2V0X2RlbnRyeV94YXR0
ciwgS0ZfU0xFRVBBQkxFIHwgS0ZfVFJVU1RFRF9BUkdTKQ0KPj4+ICtCVEZfSURfRkxBR1MoZnVu
YywgYnBmX3JlbW92ZV9kZW50cnlfeGF0dHIsIEtGX1NMRUVQQUJMRSB8IEtGX1RSVVNURURfQVJH
UykNCj4+PiArQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9zZXRfZGVudHJ5X3hhdHRyX2xvY2tlZCwg
S0ZfU0xFRVBBQkxFIHwgS0ZfVFJVU1RFRF9BUkdTKQ0KPj4+ICtCVEZfSURfRkxBR1MoZnVuYywg
YnBmX3JlbW92ZV9kZW50cnlfeGF0dHJfbG9ja2VkLCBLRl9TTEVFUEFCTEUgfCBLRl9UUlVTVEVE
X0FSR1MpDQo+Pj4gQlRGX0tGVU5DU19FTkQoYnBmX2ZzX2tmdW5jX3NldF9pZHMpDQo+PiANCj4+
IFRoZSBfbG9ja2VkKCkgdmVyc2lvbnMgc2hvdWxkbid0IGJlIGV4cG9zZWQgdG8gYnBmIHByb2cu
DQo+PiBEb24ndCBhZGQgdGhlbSB0byB0aGUgYWJvdmUgc2V0Lg0KPj4gDQo+PiBBbHNvIHdlIG5l
ZWQgdG8gc29tZWhvdyBleGNsdWRlIHRoZW0gZnJvbSBiZWluZyBkdW1wZWQgaW50byB2bWxpbnV4
LmgNCj4+IA0KPj4+IHN0YXRpYyBpbnQgYnBmX2ZzX2tmdW5jc19maWx0ZXIoY29uc3Qgc3RydWN0
IGJwZl9wcm9nICpwcm9nLCB1MzIga2Z1bmNfaWQpDQo+Pj4gQEAgLTE4Niw2ICszNTAsMzcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBidGZfa2Z1bmNfaWRfc2V0IGJwZl9mc19rZnVuY19zZXQgPSB7
DQo+Pj4gICAgICAgLmZpbHRlciA9IGJwZl9mc19rZnVuY3NfZmlsdGVyLA0KPj4+IH07DQo+IA0K
PiBbLi4uXQ0KPiANCj4+PiArICovDQo+Pj4gK3N0YXRpYyB2b2lkIHJlbWFwX2tmdW5jX2xvY2tl
ZF9mdW5jX2lkKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIHN0cnVjdCBicGZfaW5zbiAq
aW5zbikNCj4+PiArew0KPj4+ICsgICAgICAgdTMyIGZ1bmNfaWQgPSBpbnNuLT5pbW07DQo+Pj4g
Kw0KPj4+ICsgICAgICAgaWYgKGJwZl9sc21faGFzX2RfaW5vZGVfbG9ja2VkKGVudi0+cHJvZykp
IHsNCj4+PiArICAgICAgICAgICAgICAgaWYgKGZ1bmNfaWQgPT0gc3BlY2lhbF9rZnVuY19saXN0
W0tGX2JwZl9zZXRfZGVudHJ5X3hhdHRyXSkNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBp
bnNuLT5pbW0gPSAgc3BlY2lhbF9rZnVuY19saXN0W0tGX2JwZl9zZXRfZGVudHJ5X3hhdHRyX2xv
Y2tlZF07DQo+Pj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGZ1bmNfaWQgPT0gc3BlY2lhbF9r
ZnVuY19saXN0W0tGX2JwZl9yZW1vdmVfZGVudHJ5X3hhdHRyXSkNCj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICBpbnNuLT5pbW0gPSBzcGVjaWFsX2tmdW5jX2xpc3RbS0ZfYnBmX3JlbW92ZV9k
ZW50cnlfeGF0dHJfbG9ja2VkXTsNCj4+PiArICAgICAgIH0gZWxzZSB7DQo+Pj4gKyAgICAgICAg
ICAgICAgIGlmIChmdW5jX2lkID09IHNwZWNpYWxfa2Z1bmNfbGlzdFtLRl9icGZfc2V0X2RlbnRy
eV94YXR0cl9sb2NrZWRdKQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGluc24tPmltbSA9
ICBzcGVjaWFsX2tmdW5jX2xpc3RbS0ZfYnBmX3NldF9kZW50cnlfeGF0dHJdOw0KPj4gDQo+PiBU
aGlzIHBhcnQgaXMgbm90IG5lY2Vzc2FyeS4NCj4+IF9sb2NrZWQoKSBzaG91bGRuJ3QgYmUgZXhw
b3NlZCBhbmQgaXQgc2hvdWxkIGJlIGFuIGVycm9yDQo+PiBpZiBicGYgcHJvZyBhdHRlbXB0cyB0
byB1c2UgaW52YWxpZCBrZnVuYy4NCj4gDQo+IEkgd2FzIGltcGxlbWVudGluZyB0aGlzIGluIGRp
ZmZlcmVudCB3YXkgdGhhbiB0aGUgc29sdXRpb24geW91IGFuZCBLdW1hcg0KPiBzdWdnZXN0ZWQu
IEluc3RlYWQgb2YgdXBkYXRpbmcgdGhpcyBpbiBhZGRfa2Z1bmNfY2FsbCwgY2hlY2tfa2Z1bmNf
Y2FsbCwgDQo+IGFuZCBmaXh1cF9rZnVuY19jYWxsLCByZW1hcF9rZnVuY19sb2NrZWRfZnVuY19p
ZCBoYXBwZW5zIGJlZm9yZSANCj4gYWRkX2tmdW5jX2NhbGwuIFRoZW4sIGZvciB0aGUgcmVzdCBv
ZiB0aGUgcHJvY2VzcywgdGhlIHZlcmlmaWVyIGhhbmRsZXMNCj4gX2xvY2tlZCB2ZXJzaW9uIGFu
ZCBub3QgX2xvY2tlZCB2ZXJzaW9uIGFzIHR3byBkaWZmZXJlbnQga2Z1bmNzLiBUaGlzIGlzDQo+
IHdoeSB3ZSBuZWVkIHRoZSBfbG9ja2VkIHZlcnNpb24gaW4gYnBmX2ZzX2tmdW5jX3NldF9pZHMu
IEkgcGVyc29uYWxseSANCj4gdGhpbmsgdGhpcyBhcHByb2FjaCBpcyBhIGxvdCBjbGVhbmVyLiAN
Cj4gDQo+IEkgdGhpbmsgdGhlIG1pc3NpbmcgcGllY2UgaXMgdG8gZXhjbHVkZSB0aGUgX2xvY2tl
ZCB2ZXJzaW9uIGZyb20gDQo+IHZtbGludXguaC4gTWF5YmUgd2UgY2FuIGFjaGlldmUgdGhpcyBi
eSBhZGRpbmcgYSBkaWZmZXJlbnQgREVDTF9UQUcgDQo+IHRvIHRoZXNlIGtmdW5jcz8NCg0KTG9v
a2VkIGludG8gdGhlIGNvZGUsIEkgdGhpbmsgaXQgaXMgZG9hYmxlOg0KDQoxLiBFeHRlbmQgc3Ry
dWN0IGJ0Zl9rZnVuY19pZF9zZXQgd2l0aCAic3RydWN0IGJ0Zl9pZF9zZXQ4ICpzaGFkb3dfc2V0
IiwNCiAgIG9yIGEgZGlmZmVyZW50IG5hbWU7DQoyLiBBZGQgX2xvY2tlZCBrZnVuY3MgdG8gc2hh
ZG93X3NldCwgYW5kIHRoZXNlIGtmdW5jcyB3aWxsIG5vdCBoYXZlIA0KICAgQlRGX1NFVDhfS0ZV
TkNTIHNldC4gVGhlbiBwYWhvbGUgd2lsbCBub3QgZ2VuZXJhdGUgREVDTF9UQUcgb2YgDQogICAi
YnBmX2tmdW5jIiBmb3IgdGhlc2UuIA0KMy4gX19idGZfa2Z1bmNfaWRfc2V0X2NvbnRhaW5zKCkg
d2lsbCBuZWVkIHRvIGxvb2sgdXAgaWQgZnJvbSBzaGFkb3dfc2V0Lg0KICAgQW5kIHRoZSBmaWx0
ZXIgZnVuY3Rpb24gbmVlZHMgdG8gaGFuZGxlIHNoYWRvd19zZXQuIA0KDQpEb2VzIHRoaXMgc291
bmQgc2FuZT8gDQoNClRoYW5rcywNClNvbmcNCg0K

