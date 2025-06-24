Return-Path: <bpf+bounces-61457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE12FAE7265
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD003BE09A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578425B303;
	Tue, 24 Jun 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D02beQnM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE61F12E9
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805035; cv=fail; b=T2vujRPBAQ7jS4IceRbp8GSTMZBBOfcHzTAjPkoTCYYN+66XCfvMqZvKVvu7gzoIsy7TA/moSkBjnikhNoHIxrIc2aoia0r/tQqCA08cTbnSDj0+4qTqjdnLQV6NR346SNYg3n7fxEMzwes8Ksb89CvTJtDPm9kteU1LyiGNjLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805035; c=relaxed/simple;
	bh=7jWJ8E89EXmRieZogurcmtQIcM/07958Ul0FEU1kHsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAz/FSWCxh0XHwAEGIwqIgOVdiZVGwf2EmOQzYARGeJYKoUC1r+Vq/RwdYyOP5G7VHBv8z9r+xD02oxgt3bLGBMbIXlaRQUyTV5cnKQ+7ZBcMGYaDSDyoGEBqJ7+A7HTa9MzH15aQLIsFv5wxHlFbuFk4tOA0GDY309QWp/sGHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D02beQnM; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OLR5aX015338
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:43:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=7jWJ8E89EXmRieZogurcmtQIcM/07958Ul0FEU1kHsg=; b=
	D02beQnMxlESZyNApzL5rjPSo3+6bT8DGPS/1lKjgwCztaY3om0yiD/SD3lMuugT
	dyJQDYpn/3jM5kJopIdQgZ4wP4icrrn1mNltjFF1nnMQ1waa/Prm6tGyvTrR80HR
	L/7gjCQFiR/LhAll2ePVWnwMZatGyKFyLaEsqxCrQ9nyjoaWuVbEhPtbDI8eO9Yx
	6QpChAJ2YX1vuwla/MdjsrvF9hqp4V3W48LSIR0IFU/xj/ubj+IkpMns3/8D40Mw
	3tX6jbuIHNKrABJ/q6kZ2sao0VJVgwwXK+6YSLcuwe8NA6/Nq86S7AcocLe+hc6q
	1OMmTyHfH3quK4NO3XCULQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47fkh6qhs8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpasESN2J2IphX3Dw28F2y4Vi9JE8kWQ0btzkwRLpU4K8UugGBQpHX/1C9xv+vq3RlkQ/z38GHFKbFxLlMOu8GyHmPIeebV+3SHaxVJI/3BGFwc0mszBt7Xve/V+B41FrVKWRf3IAPcHBwospWpS+6CWhs82ArDAWqg2nDeQPvPgOujTXm5M5qSQlf3mrbpuV+BIby0wXP01VS5cVAM7CCkonZyFqJoi9dqvGM9o83G3NmkxQ6yeO/f/iYj0CHLLkYqtNqbqeT++jzMZnTFg3mcT3inSloqStM7Zot3XHHdycgbOtTc7oByu/SHz4tpL7grG4maW1PvqER8WiQTDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jWJ8E89EXmRieZogurcmtQIcM/07958Ul0FEU1kHsg=;
 b=m8pVxi9RAStPJZOvNuLJbGu0scYGqF+nijvYaa6iVATPLZcfzQ5/gS2vKli2gqemqtRaL9J1WRWKVMAyX8B6ppiu1SNfnw/Xhmc+/Xc77CnX0lve5NSo83JXAY/6uF9sw4RQndKfYK11FHqp5LVyF4Qxe6K0QopqCzw4jmebDDuRKtiTkCOTPz4n7RgnpW4NhYfnQaN9NtKhKN8GMiAJXl6iH6Evd9JD8F/xXfYugffdBUmR4b1j2Re1jSYQVfCsjfWf1R0R+FT8WjSTOSi8AdL46iA41Bix+uYeeuLj5ZsxO7tVFFO84v0IU37tezSifzYvahWh75cWtDx+3VxXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4055.namprd15.prod.outlook.com (2603:10b6:5:2be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 22:43:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 22:43:49 +0000
From: Song Liu <songliubraving@meta.com>
To: Eduard Zingerman <eddyz87@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Thread-Topic: [PATCH v2 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Thread-Index: AQHb5VN1QaOAPtziz0eHfefdT0m4ybQS4COAgAAIDwA=
Date: Tue, 24 Jun 2025 22:43:49 +0000
Message-ID: <8E882CF2-2888-47FC-A72F-1950A25CC6A0@meta.com>
References: <20250624220038.656646-1-song@kernel.org>
 <20250624220038.656646-2-song@kernel.org>
 <19803713ab26e3c464710c9e9bae60c7dbb8fdd9.camel@gmail.com>
In-Reply-To: <19803713ab26e3c464710c9e9bae60c7dbb8fdd9.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB4055:EE_
x-ms-office365-filtering-correlation-id: e0597d40-79ed-4f01-50c8-08ddb3709628
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFJOSTNEYmxrY3dNWUxzdGtqUE41WGtjaXhBZld0VEVvZDZyUVpYYnVrWjZj?=
 =?utf-8?B?U3hYSUVpSUlqc3NObmljTmJQVURiNFdEUlJSemIyN2RHOHhUV1JUMGQvcSsy?=
 =?utf-8?B?Zk9ZS2dJV3NtbzNOUlhnNkVuZitPUkg0dXEzck81OW5oOTE3YUEwTllQMUhF?=
 =?utf-8?B?ZFU5emNqV1Y0SVNBSUp6YWpJUDkwV0hJaXdZbVNJNDNsYTdXYzhzQnZ4WW10?=
 =?utf-8?B?MGVha1BVQUdlQ1duVjVEWXU3bXp2M2EyNGJNOEhZOStGVHhzd1U0M1hnbnRE?=
 =?utf-8?B?ZHpiRUMvL1V5Qkt1M01hVFlEY0xkaU1ZTUR3NHpzZk1hSm9rVHhLSUtHd1ln?=
 =?utf-8?B?UFVYYVBQSTlKV2QzekV1UldQV1g1NFl4UlZoSisyMzBTcjJ0R1ZMZzJocDJF?=
 =?utf-8?B?c29KYXRlRENSSUFuUUlieHhvWUFielpzRHNPc1RUcnRHdEVUWnN2YmFYbkls?=
 =?utf-8?B?Mm03Q0I0N0p6dDVsbFI2WnJFamY0cElTM2FjS2JDRE9ERFJtN1UvQ2d5T3dl?=
 =?utf-8?B?OTlEd3JTOXVhZUJQWVdnanhBTkhLQSsvYjArM1JJM2dTNUIyeXNJUTViYWpG?=
 =?utf-8?B?MEd4b29lU0VYV0t6T3QveVI4aUhJai8wNzkxQ3ZxT2VHck8vdlh6TzhCQnd0?=
 =?utf-8?B?UlJvdGQ1bzNvWm16SUxSbVpTWUtRRDREUkgwbGJnejUyblJYZWdHWlkxZlZK?=
 =?utf-8?B?TW9ETGNUZEd1eEIrMFVLbmxoQ3VZS2pmRUYvdENMSUJLMUI4b2N4bmdGUlZ5?=
 =?utf-8?B?ZWY5NXdUem9qWDJFbWh5bVNtTjFGTlhRWktBakQwMXlsSHFLNngzSVR5S0RN?=
 =?utf-8?B?NVc0Y0IvV3RRUGpyNUtrU09LanFLTnZ3SDk1TTU2U2NUQWJQQkZNa3VRaS9I?=
 =?utf-8?B?NGpnVlJMdzQzOUJWbHhxdnNiV2Vta2JFWE1tMFZQY3g0dVZVaUFvR0c2MXk1?=
 =?utf-8?B?N2Z0dC9hZ2xRQzcrcW41NTFVRDFzVS9oOU1hbnlLM1pCQ1NBOVpKTlJzcndE?=
 =?utf-8?B?YU5YbnUrTWlZQmVtaHY1MW1KK3ZTczZnQXdEd1pCQ3hvQnpSYVRuZnFCZHVn?=
 =?utf-8?B?RUxrSGNCYUErTWxNYytJaWp5amF2QnJWczFGcmJSZjU5YzVjaVNXbnpIelhH?=
 =?utf-8?B?YmZBUElJb3pBNnkzRTFlV25DT3RGald5TndKVTJCZFZVL21QWWRXSlYrcmV1?=
 =?utf-8?B?alNqM0RnNStwSlp3OUxVZ3JwUmU2TU1id2lrOHhIbmFVa0xkZUtmd1owSit5?=
 =?utf-8?B?NVdtWDZ3R0ZkbVpncms5N29nR25ONjhhZjloY2ZQb0poT0Z0WG5LcFZXYWNi?=
 =?utf-8?B?OE5DRFlWQzNNbEZlSWFUVVNvZEM2ci9RMnRSclNjU3dUMy9XVEZKSWhaMFcw?=
 =?utf-8?B?REVoVThJVnRONWEyMjVmZDExM3hka3QrOVVjZDJQSEZxVTVMWlZldnpjTzFx?=
 =?utf-8?B?N3Z4QlBoUjZGMUJacHpHNGk0TEMzNHMzUWhNb05MZi9qcm93bkNLK0IrNUFI?=
 =?utf-8?B?Sk9Td0pTN1R3VVhOczJTRDMzamdjSWMxR1Q1clZveXo0RHNkUlZXcHpsTWJv?=
 =?utf-8?B?K3pGNE9PL3hmSDNYTTJCSkYxb0F0d0lOMWtlS25aaHorLzRCcnliNUFkSDdN?=
 =?utf-8?B?dkl6N3VZZTIvMHJiZXcwOUJvRndPQU1xYks2RkNqTFJkMzB3RTBIOTExM2l4?=
 =?utf-8?B?anArZzBMMkpSYmtVL2JYRTVBczFQWlczaUNDRnphaWZ6Qlk4OWE0SEtIdnpj?=
 =?utf-8?B?SU92cVJ4QnFobTZGQnBTdVJFdks5VjhlaXZyYWVpT3pkeUFhcm9scXRyUlVw?=
 =?utf-8?B?WkN4UTNBSGZ4anV2RDhPbEZ3ZmpRd05tdTlVSVEvT1BiL2c0cnFGS2tRWE9l?=
 =?utf-8?B?TEhHNFR6V3o3clZpcFRLKzk4UkpIeThoa0ovNkJURHYvaEkvQmJhZm4wcTZJ?=
 =?utf-8?B?YmZDdnVjYWJXUmkzWUdKb0ZaWjlhNldJUmlZS2JXdTNmeVJuNUtzdlh3Lzd2?=
 =?utf-8?B?TnJ1U1d3M2tBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm1IRU1QeC83RWtBTWwxaHVsbW9sdVppL2t4Qmlpb0k1T3ZxZUhxYlFYeDZa?=
 =?utf-8?B?TkMycUxMWU9mU2ZWbDA0aDBKQnYvbXZNZmY0Tkp6K29XazJWNlJRN1k4RzFC?=
 =?utf-8?B?ZWZ3dXdZaFpyOWpxWHY3T2RDeU4rNnEzN1BOVnIzUitQcllzZkhnUXdDaGkw?=
 =?utf-8?B?VnV3UlNzLzdCdWVUNVBQQTZucXVNdEQ4azErTjZFOStId3M0Z1RabHF4WWlt?=
 =?utf-8?B?VTBDZHhDdE9iTjJPSWl0Mk5aRDhEUmsxRU9yY2hjOHhHQUxMV0hrKzVQam5x?=
 =?utf-8?B?bUtvSGFaWFBGN1JIL2VVVWwyS0daenQ5dDRJSnNZY0hacFU3VWlCN0M3SFBl?=
 =?utf-8?B?emh3cDVoZlE4VWxGcVcrYUpjT2RrUDRjdHZpWW5ndEFhbW5pZFZZc21ja0g5?=
 =?utf-8?B?Z3B1VGFHRnRIR0ZXMHovQWppN2xiSkNUcEk5VE1tZlZhWjFWb3o0cVFQVTYw?=
 =?utf-8?B?aEdsQ1NxWTFvQlN0QWcyd3MzdmVodVVkSzBZTC9BRkRpUnFrWHVoaGsrbmZN?=
 =?utf-8?B?SFM4Z0lvWXFFUTNiZjlWTVU4Y2pYSU1nQ085OUhWT1RHMWNmLzZWaHMxTGU1?=
 =?utf-8?B?dXlNV1BoRTB6S3llcmpieXo3MGFrMWVJQzVPampFMEs1S0MyZnNLdCtyUFBX?=
 =?utf-8?B?R2xUbkZvTzhXb3BXMkpHY04rV21PejVSaG12K1dSVVM0WjdvMzQ1MXBBbEpi?=
 =?utf-8?B?NkxqUWR2RUN4b256WThBbGIzbjVoSGdHcXVESDhXZk4xeTlLY3cxRGVBYjMy?=
 =?utf-8?B?WHpaRzFRVm9VWEowYmlVWVVtMUc1TW90bUhySEphcjhmN1IzOUc4ejUrbkFt?=
 =?utf-8?B?aU5BTlJ6aDljUW50enlkbllMeVlicEJhYXp4U1FVeTZ2STExVG5kNlJqbi84?=
 =?utf-8?B?aGJpb1JOWUZJTGJtTEJTa0xHa2cwKzNlVDZBYzRya3JwaTZld2h5MDJlSFFP?=
 =?utf-8?B?N2c0YzdCMlBJMkJzZWlTTkNXbG91Ui95OVRYcmg2d2sxaWRWeHhsbXVKcVJm?=
 =?utf-8?B?YVEzUDczVlYzaXRrT3NkWXIydUJLNDNaZ1Q5ekRQcTdBV0FLR2x3NEJxRFAy?=
 =?utf-8?B?L0xueVNTWm43ekdYaEdiamQ4TUpaVHZUUWpuVURnVUVpMTRxYU1kQ2QyZ1JF?=
 =?utf-8?B?a0NET3RHT3RuYUg2SjQ2eVJlTEdzaWdoZUI4cnFjWkVjTGpXL1ZQbDY5ZDVm?=
 =?utf-8?B?THRiWWttN3M0K3JjUkdqTjU0U1lmNGkyK1VNRk1xd21RUGRPaXdMOTlPV1Az?=
 =?utf-8?B?enR5c2trdWwrZWthcW1jOE5lTnAzNjVJTStWUmlpUkJPN2IxeDlIOHRxZVRm?=
 =?utf-8?B?V3VvN1Q5Z3ZLSGlmUHc0TXZKNnlQRVBGRkNJeWxtaWhORXFuVGgwK3ZHQitB?=
 =?utf-8?B?aDJpak03L1ZldUlzc2FhR0NxWUFyL0ZhQitwRk5vQjZhM0RHNmNJTDRrNEg1?=
 =?utf-8?B?cFlKbGJaK2JjUFZaWGF4dWVyaEFzQUs4ZVUwdnJvVHMvUzdkUVR3dGJ3cFF2?=
 =?utf-8?B?Smt2dENaWWNUQW12ek01ZWU2cENGS05BWHE2L3RUSXh4Q2J0Rm1GQWpNOXpF?=
 =?utf-8?B?bjFkSFZQVWxWNjNHQlFTNW43WU4zQUpSNTRoVVQ3QXpab3hSRnBTWXpFWUg2?=
 =?utf-8?B?cUFleWhpL085bXNBZC9SUXNGUlJ6NVJid0JhcEJFMVMxL3V4ZDhNTjZNUmtX?=
 =?utf-8?B?ZHZNZkJnNDJES1R4Q0dRMVloT29qNU5RTGZxemhjdS9CZVJsOTN2dzkzYWpX?=
 =?utf-8?B?QWdFSDNOVU5kUlFZZ1NsczhhQXhDS2wyRHhFYWN2M0g2UTB1NXNiZk0vQUxj?=
 =?utf-8?B?cEw2QVdEdEZUaTVCcGZ6d1BqN2ZsbnEzTit0SEtxU2pXOTRoTDZtQjByM1E0?=
 =?utf-8?B?SUpQSDZrWU1jSlJURSs5WUE2VlZRd0JteHFwbmprVUcwZlhDWXh0K0Z2WlpW?=
 =?utf-8?B?L3FYTGhRYitpV2VQbG9TK1hjdTRUb2p6MysyNHN3bmVBOTE3WHE2VzZkTTZa?=
 =?utf-8?B?VFBOS0R1Vm1GTE9mdVQwSm1BUWlubkhwaGt1QjNnZGJ5ZzBUS0VOV1pqS3Mr?=
 =?utf-8?B?a0EzMFVpQUwvRDBjamlCWWt3RHU0b2VIWEpDYWY4UG5SKy9BbWJNV0VNZVM3?=
 =?utf-8?B?WFYvd1hkTWlVejV4ckQrRDFPR2c1dWlrcWFLSnVheGw4cFRtQ2RVR25hUmpQ?=
 =?utf-8?Q?507oK7QVMmdsY/Bkn1b51ds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A2B01C40FD8E449C80358F178CCC9F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0597d40-79ed-4f01-50c8-08ddb3709628
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 22:43:49.2995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNxQM44UCR4SebofikYsnvZi+X+3HRPD51kk6ncnYEKqwTqRVy3DvWarfm0WHfiqg/KT6+WXkb+QENM2c/sMHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE4MSBTYWx0ZWRfX7+fr1VFwMUP1 7pwgu57vQLneJrlI7u9zBKCdUlaGzrFelKcU4ngWRpL82re/pcPZk3ewBPI29ePz8qa+3Hh40bc WBBbx3jtCycpnLgYteZLeg3ET/s6jps56mFJ26wUQ3IhZ/dxaDGd0suFDnRVhzm0PLKk39Z8fwC
 AWVmjpkHYObGiOr88HTsqszmjbqY+gxzuT3vRJB2Lsfj6z/s2EnxsDgtO9CXLlWb3Hmxnv4+AWR lRGwHN8Fyo1VlZTrDHH7Z4ZwqWgQTAZFiGqsUjE5k7JcrgH8jZQksZweDHzH7+4q1MxAH7EXEbF 66zR25hsiYy3FedNm6yH7cQr4I5FC4JmH8FVibVLD7zf4XV+oLu5dsCqkk4+iVmUBptDM+kwHrB
 cpk/137FlR38N4DTqhPc+kQQ5LUWqIVbpPfmZnFZU9LoXtgYyQmDbIEx9/GG5A8RBGkteAim
X-Proofpoint-GUID: YmMtsMYcAK3fIY4cq8mae6piy0cfwulb
X-Authority-Analysis: v=2.4 cv=A+tsP7WG c=1 sm=1 tr=0 ts=685b2a28 cx=c_pps a=g+dQH1R+REXWkVycoqRBYA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=H0PhrijIm4kpWxcilHoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YmMtsMYcAK3fIY4cq8mae6piy0cfwulb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

DQoNCj4gT24gSnVuIDI0LCAyMDI1LCBhdCAzOjE04oCvUE0sIEVkdWFyZCBaaW5nZXJtYW4gPGVk
ZHl6ODdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNS0wNi0yNCBhdCAxNTow
MCAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfYm91bmRzX2RlZHVj
dGlvbi5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX2JvdW5k
c19kZWR1Y3Rpb24uYw0KPj4gaW5kZXggYzUwNmFmYmRkOTM2Li44ZDg4NmMxNWZkY2MgMTAwNjQ0
DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfYm91
bmRzX2RlZHVjdGlvbi5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MvdmVyaWZpZXJfYm91bmRzX2RlZHVjdGlvbi5jDQo+PiBAQCAtMTUxLDIxICsxNTEsNCBAQCBs
MF8lPTogcjAgLT0gcjE7IFwNCj4+ICIgOjo6IF9fY2xvYmJlcl9hbGwpOw0KPj4gfQ0KPj4gDQo+
PiAtU0VDKCJzb2NrZXQiKQ0KPj4gLV9fZGVzY3JpcHRpb24oImNoZWNrIGRlZHVjaW5nIGJvdW5k
cyBmcm9tIGNvbnN0LCAxMCIpDQo+PiAtX19mYWlsdXJlDQo+PiAtX19tc2coIm1hdGggYmV0d2Vl
biBjdHggcG9pbnRlciBhbmQgcmVnaXN0ZXIgd2l0aCB1bmJvdW5kZWQgbWluIHZhbHVlIGlzIG5v
dCBhbGxvd2VkIikNCj4+IC1fX2ZhaWx1cmVfdW5wcml2DQo+PiAtX19uYWtlZCB2b2lkIGRlZHVj
aW5nX2JvdW5kc19mcm9tX2NvbnN0XzEwKHZvaWQpDQo+PiAtew0KPj4gLSBhc20gdm9sYXRpbGUg
KCIgXA0KPj4gLSByMCA9IDA7IFwNCj4+IC0gaWYgcjAgczw9IDAgZ290byBsMF8lPTsgXA0KPj4g
LWwwXyU9OiAvKiBNYXJrcyByZWcgYXMgdW5rbm93bi4gKi8gXA0KPj4gLSByMCA9IC1yMDsgXA0K
Pj4gLSByMCAtPSByMTsgXA0KPiANCj4gSXQgbG9va3MgbGlrZSByWCA9IC1yWCB3YXMgdXNlZCBp
biBhIGZldyB0ZXN0cyBhcyBhIHNvdXJjZSBvZiB1bmJvdW5kDQo+IHNjYWxhciB2YWx1ZXMuIEl0
IGlzIHByb2JhYmx5IG5vdCBzYWZlIHRvIHRocm93IHRoZXNlIHRlc3RzIGF3YXkgb3INCj4gY29u
dmVydCBmYWlsdXJlLT5zdWNjZXNzLCB1bmxlc3Mgd2UgYXJlIHN1cmUgdGhlIGxvZ2ljIGlzIHRl
c3RlZA0KPiBlbHNld2hlcmUuDQo+IA0KPiBPbmUgb3B0aW9uIHRvIGtlZXAgdGhlIHRlc3RzIGlz
IHRvIGNhbGwgYnBmX2dldF9wcmFuZG9tX3UzMigpIGFuZA0KPiBvYnRhaW4gYW4gdW5ib3VuZCB2
YWx1ZSBpbiByMCBhcyBhIHJlc3VsdC4NCg0KSSB0aG91Z2h0IHRoaXMgdGVzdCB3YXMgdG8gdmVy
aWZ5IEJQRl9ORUcgdHVybnMga25vd24gY29uc3QgaW50bw0KdW5rbm93biwgc28gSSByZW1vdmVk
IGl0LiBCdXQgSSBndWVzcyB3ZSBzdGlsbCBuZWVkIGEgdGVzdCB0byANCnRyaWdnZXIgIm1hdGgg
YmV0d2VlbiBjdHggcG9pbnRlciBhbmQgcmVnaXN0ZXIgd2l0aCB1bmJvdW5kZWQgbWluIHZhbHVl
Ig0KDQpMZXQgbWUgYWRkIGl0IGJhY2suIA0KDQpUaGFua3MsDQpTb25nDQoNCj4gDQo+PiAtIGV4
aXQ7IFwNCj4+IC0iIDo6OiBfX2Nsb2JiZXJfYWxsKTsNCj4+IC19DQo+PiAtDQo+PiBjaGFyIF9s
aWNlbnNlW10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsNCj4+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfdmFsdWVfcHRyX2FyaXRoLmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfdmFsdWVfcHRyX2FyaXRo
LmMNCj4+IGluZGV4IGZjZWE5ODE5ZTM1OS4uNzk5ZWNjZDE4MWI1IDEwMDY0NA0KPj4gLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3ZhbHVlX3B0cl9hcml0
aC5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJf
dmFsdWVfcHRyX2FyaXRoLmMNCj4+IEBAIC0yMjUsOSArMjI1LDcgQEAgbDJfJT06IHIwID0gMTsg
XA0KPj4gDQo+PiBTRUMoInNvY2tldCIpDQo+PiBfX2Rlc2NyaXB0aW9uKCJtYXAgYWNjZXNzOiBr
bm93biBzY2FsYXIgKz0gdmFsdWVfcHRyIHVua25vd24gdnMgdW5rbm93biAobHQpIikNCj4+IC1f
X3N1Y2Nlc3MgX19mYWlsdXJlX3VucHJpdg0KPj4gLV9fbXNnX3VucHJpdigiUjEgdHJpZWQgdG8g
YWRkIGZyb20gZGlmZmVyZW50IG1hcHMsIHBhdGhzIG9yIHNjYWxhcnMiKQ0KPj4gLV9fcmV0dmFs
KDEpDQo+PiArX19zdWNjZXNzIF9fc3VjY2Vzc191bnByaXYgX19yZXR2YWwoMSkNCj4+IF9fbmFr
ZWQgdm9pZCBwdHJfdW5rbm93bl92c191bmtub3duX2x0KHZvaWQpDQo+PiB7DQo+PiBhc20gdm9s
YXRpbGUgKCIgXA0KPj4gQEAgLTI2NSw5ICsyNjMsNyBAQCBsMl8lPTogcjAgPSAxOyBcDQo+PiAN
Cj4+IFNFQygic29ja2V0IikNCj4+IF9fZGVzY3JpcHRpb24oIm1hcCBhY2Nlc3M6IGtub3duIHNj
YWxhciArPSB2YWx1ZV9wdHIgdW5rbm93biB2cyB1bmtub3duIChndCkiKQ0KPj4gLV9fc3VjY2Vz
cyBfX2ZhaWx1cmVfdW5wcml2DQo+PiAtX19tc2dfdW5wcml2KCJSMSB0cmllZCB0byBhZGQgZnJv
bSBkaWZmZXJlbnQgbWFwcywgcGF0aHMgb3Igc2NhbGFycyIpDQo+PiAtX19yZXR2YWwoMSkNCj4+
ICtfX3N1Y2Nlc3MgX19zdWNjZXNzX3VucHJpdiBfX3JldHZhbCgxKQ0KPj4gX19uYWtlZCB2b2lk
IHB0cl91bmtub3duX3ZzX3Vua25vd25fZ3Qodm9pZCkNCj4+IHsNCj4+IGFzbSB2b2xhdGlsZSAo
IiBcDQoNCg==

