Return-Path: <bpf+bounces-45563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053419D7B19
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 06:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F4B2153B
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF6145B2C;
	Mon, 25 Nov 2024 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u.nus.edu header.i=@u.nus.edu header.b="KMGb6FOu"
X-Original-To: bpf@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021079.outbound.protection.outlook.com [52.101.129.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9741374CB;
	Mon, 25 Nov 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512256; cv=fail; b=g3QyVZJueJgiBid2vVN5aoeDJ/C4xqCuG954QV6kRxc2nxp/SndalvB4T3KnO49I9RIzMgu6hQcOgP63NyNmIcaU9IyVVgAAp4oesKsN4fMYp/tcHfaYU5AXEM5iV+47JlQ8hwdTxLF9xB/RV9BBrQfutvDuZk8JBh+u58W7RJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512256; c=relaxed/simple;
	bh=iDd+FRk6RkVqYZbWHpzCePrb7U1kb154ctH7oZK9qwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qT3RpaPi4ctviMBVpeE3C1e6UQV0dKIFhnT58IKd4rJtwPVJBQQn3SQR3dwK/VLwHpnKRW7sGmapa1OREGB6f7lYNNd92qiHnUA1RUkWVuoN8QzmmVFg0XFNrX/lGhFlnKp5lEnjA4hqI6H9D0wh3M05i2YRm60R+CuDdNxrpyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.nus.edu; spf=pass smtp.mailfrom=u.nus.edu; dkim=pass (2048-bit key) header.d=u.nus.edu header.i=@u.nus.edu header.b=KMGb6FOu; arc=fail smtp.client-ip=52.101.129.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.nus.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.nus.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou6INPDFSuedrkeZj8P5YUQMUn5FyHSDVYfBR9hCJIXYnGsJ+/qTJ63j2Xelc7OlTLoM2nV9QIEgq/zKUE5i0ycKM1//Gyhdsp7BKO4u7Wyk5Vl7xOsdwbM8Xxp3XZRBk/W1ilmehqoYXtuYPKO2EkthCMyD3gqBRN0tB+8JRXBaiYhwVJI44x7kj/49O+wYd94fH0jAuIIIRBsaefHDpMMQJ2OPNNWcS1cahj/ChHrvjNAkk2l5uY6xftna1lFoZn35K2xtBJKs6D5zUr6hSmTV+9AxxaVxoUhM6PPXOnS+K/RC39dZtrKFPs1+lFcrXRy+w6At91fJSoMJdYcm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDd+FRk6RkVqYZbWHpzCePrb7U1kb154ctH7oZK9qwk=;
 b=ANaUiP4N6F8Y6YpykuxQoCbhSjrnOec7PqRJ50Aw2Pz7ogeLLRdmKcxQqoBTEDKbHMpSQLTYPuAPST5CVbVdlcfwhFSRIRQqlpOYv3FOpKtopp1DppvwxCiMYiAi7Fpid8L5JuAtIzbGjaWcUciPz9/1DSFUzUxXAGGKLXLfH1t16acBbbQ/HRukyx7TbehOpK+siZ3T2NF/BUTXDwdgBCxPdHjTSf8RtubmTUr/rkWkAoNlQwDUBJLFFxWDQZLkWDzrjKtFRSPv+AqdIsDLUjGd6gnCtjesCtjeZvt3kgxBhsAwlBBaopcP8ksUxeXVnU73rLS1Dvnr+AvJHN4Q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u.nus.edu; dmarc=pass action=none header.from=u.nus.edu;
 dkim=pass header.d=u.nus.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u.nus.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDd+FRk6RkVqYZbWHpzCePrb7U1kb154ctH7oZK9qwk=;
 b=KMGb6FOuEYcC3UaBV0OMEACO5ORfO/uBiwaN9lWvowHDiUSTr82t17tzEcva4/p6PRelDkfeZPFycUw2hjD9lr3zf/UHDVA6jplhyPIbvbMwIdJCTQ5sUyDq7JTb57NiIw6134DT0nwKL9QqfZX/wT2TOYXmk9lX6uh+Ilzk8CPpNBhxcgftCwmdvJbnAy9d36XXnzTXvklmpdANW1VvFTNa7J6g/d/gf8yCGNaBAmdlOsO2217Zkva44VHRVrilf0+vBYaR8LcwDXAPESWAPjjgkqZADlPhgjI9U3w70NeIE8FvuxDCxEbAO0SZnxU5G8aut+blsBQXXo4j7VUiQA==
Received: from TYZPR06MB6807.apcprd06.prod.outlook.com (2603:1096:405:1c::14)
 by SI2PR06MB5172.apcprd06.prod.outlook.com (2603:1096:4:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 05:24:05 +0000
Received: from TYZPR06MB6807.apcprd06.prod.outlook.com
 ([fe80::5bd7:7352:17f9:fb65]) by TYZPR06MB6807.apcprd06.prod.outlook.com
 ([fe80::5bd7:7352:17f9:fb65%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 05:24:05 +0000
From: Ruan Bonan <bonan.ruan@u.nus.edu>
To: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com"
	<mattbobrowski@google.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Fu Yeqi <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Thread-Topic: [BUG] possible deadlock in __schedule (with reproducer
 available)
Thread-Index:
 AQHbPVlWwf4xaIx8MEKQU85bhR9hiLLFUZoAgAAqiwCAAcVZgIAAGKKAgAAD5ICAAKHfAA==
Date: Mon, 25 Nov 2024 05:24:05 +0000
Message-ID: <5489FB30-8B09-4F74-9C2B-FF25F4654A3F@u.nus.edu>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241123202744.GB20633@noisy.programming.kicks-ass.net>
 <20241123180000.5e219f2e@gandalf.local.home>
 <CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
 <20241124223045.4e47e8b7@rorschach.local.home>
 <20241124224441.5614c15a@rorschach.local.home>
In-Reply-To: <20241124224441.5614c15a@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u.nus.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6807:EE_|SI2PR06MB5172:EE_
x-ms-office365-filtering-correlation-id: d72983b4-2e5a-438c-bae0-08dd0d116150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Njc1V1Bub21icHN3QUtrWHJQdTh1R2RWMGN5YkJyaHRSVGRSUUUyUjk0dW0v?=
 =?utf-8?B?bnlaRC9XajIvWUFyS01PamlwVENiVk9nQm5HSEd2MmZ6Rm9Dc1I0RGFzcVJE?=
 =?utf-8?B?bUYvdWkva09XeVB1dzNINGJTSTNkb2hBSWJqK0Z6ODRZRVJKdUx3cVJoeWo5?=
 =?utf-8?B?dVBSaDVIazhLdy9ER2RJVmRhQ1NsWkhTbG1WcnB5dWZOdm9idzBHU3VyOVVo?=
 =?utf-8?B?MHhyUTZmN0Y0ZG0welJwSmhOUC9lR2hvUXQ1Y3VUbnltTis2eS9uQmNKU1ZP?=
 =?utf-8?B?Y1RJWVptRjI2eHVVanRoTURPZTZ3R3MxVi9mOVk1Ym9NYlpCWWorZVlVcHNu?=
 =?utf-8?B?cVl1RU1iT1NsYldocmNvTGkrZmExVmJZdDd0a1JlS0I3VEh6cEtyTzdsVFdJ?=
 =?utf-8?B?ZEZsdkZrcGtpMmV0QVdUdDczN1NnU3I2QU1NSGxSRzU5b2dMTzdyOXlKZUJN?=
 =?utf-8?B?cXhzV0R0a2hyU3RkZnl4bitqenJxNzgzdUswMjBnaGpBVDNvaWtWMklWZnFC?=
 =?utf-8?B?YXlEYTg4a3BWaEczUUNxcmtuNis2SlF0ZmhMVTNxMGc2WlZrYnd0Uk5BZ0R6?=
 =?utf-8?B?b25rSXp6MXdEeDNuWXNOU2VhUGo4Nk9XOTIyekk5Q0FTT1N3M29nRmpERnF4?=
 =?utf-8?B?YWxjbUE4QkgzWHdlQkE3Q2pybjBxKzZqdkN3Z054THRZQ3VzMFdRRHFKbElu?=
 =?utf-8?B?d0grYU8vNTh2RUpnUi9sS1Foa0VxNWRDOHU3V21tby9xK2tXNkxVWlhxdWtV?=
 =?utf-8?B?eFhxc1dqTzE4K0c3ZGlTSG1BTTgyMi83aFloUHRmSVh5bzJySjZ1NklCdmFK?=
 =?utf-8?B?K0NQdVRCcWVodWlLakQ2SmJOTHhnSEdBSDNsNkNLT1pvWkR2b0UyVWRTWm43?=
 =?utf-8?B?SXJrR0VpOHZiYnFRdU1HNVdZT1Q4cVE4a3JtWEFvd0NuSmF5aEhFOFlNVHRl?=
 =?utf-8?B?dVk0ZmJpSTNZOUxweEhrelhpRDdGQUl6dzlWdUJ1YTM4R0Q5aitpVytoQVNT?=
 =?utf-8?B?LzJqbFVoTHE3ZkZmTitsYTRVZzZUNFY0YWMraGRFWWMyU3dhLzZ3dUxCazFu?=
 =?utf-8?B?ZnZHVkdXODgweWpEeFBJR1pOY0NGYW5jL0lUMlVaanhjMDM4OUkwZVZGa1Ux?=
 =?utf-8?B?RERqWHhqT2RiVUhRdW10YTdhSU1XcmVqRUtZTWpOWExDVzVYbEhTc29XZ0xH?=
 =?utf-8?B?NUR2T0lxZGtpcStYUkhaa1ByNExDVDNaOHIvU0VzUkxtT1piZjdvZDVTU2lP?=
 =?utf-8?B?K3Q0ZStqSDNpWGRJTm40L0ZCZnNkZmppL29MOVdDUU04VHZKOS9KbkZsM1NP?=
 =?utf-8?B?TG1MQVlWTDJoc3dreFlvK3ZSOWE1YjNmcy9zSzdza0dqbmY2UVFBNFA3aExm?=
 =?utf-8?B?eXlJZ3c0TzUvNEJhOEorOXhjSXdEWUxoSVl0dWxMT2x3ODU2VzhudXFlRE9s?=
 =?utf-8?B?NkRjRGdOZFhUSTVERUU2YzVoTTVOZGZ4S0REclNPTXFDVEROWCtqTythSHd3?=
 =?utf-8?B?Q3FVeEVoMmtoUDBiUFIxOWg4V2JRTUM5NERrUTZtc3krNndsVkFoWE1TcUFT?=
 =?utf-8?B?c3B5NU5Ia1JUOW9VL0JTZndsaXIrYVhCUGQ0V3VSMHZKdXRYN09SWDJJSlgz?=
 =?utf-8?B?RFN6Z3pvWEVqYnFKRVpPUjd4OTQ3MnE3SU5JaDNJT0pmNkRCZmFKVWhiTFgw?=
 =?utf-8?B?Vjc2VWhISW50eDdmU24xc1JZRnhtK1NoL2dVbDdzbDhlZS9HOGNMSk1GaUQr?=
 =?utf-8?B?NFVnekE4RWcxbENxZ0M5MDJOS0l3VmNxTlJ3eG9rSGFaUWxIZEQ3TkJic0l2?=
 =?utf-8?Q?br78B79HPuWfYkYN7Mtm1p9zmQuGA3PRwvh+k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6807.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUZEWElWZzBSbFQvallzOGdTbWxJT2xNc2p6UWJENnlBajQ0SFpqQkZLMXJL?=
 =?utf-8?B?aG1sTnVoeUFQVVI5eEFGeXBHQlpsTmtYYkliellUam1PbU5ySWZ0VWVtMklH?=
 =?utf-8?B?aHdLTXdPWFZhMmRpN3hhdlhEWnpnOFMzZXJDOGF3cUpndTU3S3F4bXluVTc5?=
 =?utf-8?B?RjhsazZmVTNjemhpWWp6NnMvcnkrbFU4ekpyci9JM1JVekZBRERwelBBTkRr?=
 =?utf-8?B?R2toeDB1Zy9jT1g1WFExbEtMWjdic0J5dDlmTXhrZlI2dUQrWTFsd0w3RFJw?=
 =?utf-8?B?SVpKRFBYWFR3UENDUnJaTllRMGpQeXpRZWVvRXBYMS9QYTdudjZjaVhnVEpx?=
 =?utf-8?B?NW82WUhkUm9jNERHbU05TlpOVytFWW5wb0RvK0pWVGJ3Yk9DQXlLaE9DdDU3?=
 =?utf-8?B?L0Z5L2lsVWVnM05VeG5JNEVpNzMyanpVbE1kWG5jdlRvaEc0ZTIxYWdXblBq?=
 =?utf-8?B?OVlZNjNVVlROTGFJVUxCQ1BlMnh0VFZ5dG1BTDdJSDRqQlNPUGt3SmwwMDhC?=
 =?utf-8?B?Rm1tRGFiNmtRbmUza0NkYkhEQnp3bWU3eEI5dWt4alBuYXRWaVM4b1JGMW4z?=
 =?utf-8?B?R0NXU2ZHRWNyb3djRXU3NWlQcGhrUVNXTTlMUzR3STBpWkd5ZHBmMVJPS29B?=
 =?utf-8?B?NGtjeTJ0SlNDYktFUUFLSnVyRmVWbnVjekdXOG8zb3RsSGFKbXJTMElJNFNr?=
 =?utf-8?B?SlZBK1hVSGpYYTRVQmhXQ1Y2SGYrcjM4cmpBOHdmVWpoelRBUm1kemZCYlpy?=
 =?utf-8?B?VlpwM1kyVjJBTlNHV3AyWVA0cTZOODQ1MVBURTdqaGZNeENtbllLT1BQa0pP?=
 =?utf-8?B?MjFXUkMvOW1DZko2OHVVZ3VXL0E5S0xseENMK3MyTUdCOTRjUHNWbTNZcUQw?=
 =?utf-8?B?RG1tSkh0MGRqbnZ5WG5nYzlKYVRFTXZhWlVmeUwzQTdNWmMyVCtTSWpINnlu?=
 =?utf-8?B?cG1nS1gxODhqUFF1SUc3dG12eWU5WWhqcHczSFU4dTFJVFd0cER2WFE4U1dq?=
 =?utf-8?B?d3c5WXhEUDNLT0NuRE5mS3ZtUytCcC95bDdackRyNlhZRVM5T1VmYzdxR0t2?=
 =?utf-8?B?dldMMFg0d2JnQkQ3RGJBK3FxTWI4VGcrZ0g0ZXd3RnlGSkprc0hHNnI4ZU1Y?=
 =?utf-8?B?Y3pscmJUMFdGOHN2VUZ1NjJFQlA5NjQxdFFjSDUySkpaK1YxUnFORHNFNVpQ?=
 =?utf-8?B?OEdwSXNScHJQTWlMYmorMTk0czFpQW1DOUdmQWpJc1FHaEg4UTRYM3p2dldv?=
 =?utf-8?B?STNiclgvenZvYmdjZWhMeUk2RnA5QjZ1VFVyZHlwL0gvUUxyck5LWDBOTTIz?=
 =?utf-8?B?dEJ2SitHNTlsNXJua3VWdDgybTdwRC9CalFSSE10eE9oV1VYOFdHbGVSbzJ1?=
 =?utf-8?B?UkszTFJxTnVoU1p0U3ZhcTRmQ3VYemhnZ3R0dG9aTXZoMFNRM0FHZ1BqWW5m?=
 =?utf-8?B?Nm5NZHdPQllKTUVBK2NIRWE4bXptNUVRYWFjNkIzWlVydFllQ0ZEYStyeDNC?=
 =?utf-8?B?RnBIek9DQzFBZlEwY1pJcll6Q3dsMVIrKytzVTJzektXZmkrV3BFQVBwd29L?=
 =?utf-8?B?a0hpMExBTGlUR2FkVjRXTy8yOExVYVdpaVl5VmxPdkRtWjI0VzVGdkhMeld3?=
 =?utf-8?B?Y3Zsb1FTWVoreXprVFB1VXJlTW9obGlIaFJJRDNXU1ROZzNaOTliRmdqUHpu?=
 =?utf-8?B?QlNBNXFrUWlQdXordW05cWUyVmRVUUpDdTZJVVVoMGJDR2F2MFhYRHdmVVh4?=
 =?utf-8?B?TmtyTHlxTWdjb1IzbjVoOHpEY0kvdjFoRnhGc2ZGalVTUU10OEZQaVYwU1RV?=
 =?utf-8?B?c3RPM2NoSlc2VS9JVUZXNVV0Mndhb2duTEhVUTh0L0sxdVBFbEFnS1FFaXRZ?=
 =?utf-8?B?UFRJNHNTRk1GaVM3a2NVamd0WkJ6R0NiNW9EN3ZhN0c3T25BbitJQ0o3ZGs3?=
 =?utf-8?B?Tkd3KzMzYmVGNVczbUVoSWFrYTBQa2dtRnErUG8wUzNEd1VVRnpQanFOdEYr?=
 =?utf-8?B?NUM5a0dHbm1GdXhvbS9mMVZQUHhqeXRJcG0vZmMxc0I4a2cvbGlKWkkzcUUw?=
 =?utf-8?B?KzB2ZERVR0dCTjlNT200VW5SODZvVlZwWVZ3c3R4UjhhM0ZBbWl2TW1pMXZ2?=
 =?utf-8?Q?QIQ0gtdaO0ReaJYvu0RNKvIhX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6CC85382F6470469B77258CE7D0EF4D@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: u.nus.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6807.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72983b4-2e5a-438c-bae0-08dd0d116150
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 05:24:05.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fJxXYA301FDrtSTz+oun63KCBrIPWfypgCDFXy/cL1sI7fw2Nw5dSJumGkRaH5Cfkm97sUkqD05eDVqMkvMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5172

SGkgQWxleGVpLCBTdGV2ZW4sIGFuZCBQZXRlciwNCg0KVGhhbmsgeW91IGZvciB0aGUgZGV0YWls
ZWQgZmVlZGJhY2suIEkgcmVhbGx5IGFwcHJlY2lhdGUgaXQuIEkgdW5kZXJzdGFuZCB5b3VyIHBv
aW50IHJlZ2FyZGluZyB0aGUgcmVzcG9uc2liaWxpdGllcyB3aGVuIGF0dGFjaGluZyBjb2RlIHRv
IHRyYWNlcG9pbnRzIGFuZCB0aGUgY29tcGxleGl0aWVzIGludm9sdmVkIGluIHN1Y2ggY29udGV4
dHMuIE15IGludGVudCB3YXMgdG8gaGlnaGxpZ2h0IGEgcmVwcm9kdWNpYmxlIHNjZW5hcmlvIHdo
ZXJlIHRoaXMgZGVhZGxvY2sgbWlnaHQgb2NjdXIsIHJhdGhlciB0aGFuIHRvIGFzc2lnbiBibGFt
ZSB0byB0aGUgc2NoZWR1bGVyIGNvZGUgaXRzZWxmLiBBbHNvLCBJIGZvdW5kIHRoYXQgdGhlcmUg
YXJlIHNvbWUgc2ltaWxhciBjYXNlcyByZXBvcnRlZCwgc3VjaCBhcyBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9icGYvNjExZDBiM2ItMThiZC04NTY0LTRjOGQtZGU3NTIyYWRhMGJhQGZiLmNvbS9U
Ly4NCg0KUmVnYXJkaW5nIHRoZSBidWcgcmVwb3J0LCBJIHRyaWVkIHRvIGZvbGxvdyB0aGUgcmVw
b3J0IHJvdXRpbmUgYXQgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xOS9hZG1p
bi1ndWlkZS9yZXBvcnRpbmctYnVncy5odG1sLiBIb3dldmVyLCBpbiB0aGlzIGNhc2UgaXQgaXMg
bm90IHZlcnkgY2xlYXIgZm9yIG1lIHdoaWNoIHN1YnN5c3RlbSBzb2xlbHkgc2hvdWxkIGJlIGlu
dm9sdmVkIGluIHRoaXMgcmVwb3J0IGJhc2VkIG9uIHRoZSBsb2NhbCBjYWxsIHRyYWNlLiBJIGFw
b2xvZ2l6ZSBmb3IgYm90aGVyaW5nIHlvdSwgYW5kIEkgd2lsbCB0cnkgdG8gaWRlbnRpZnkgYW5k
IG9ubHkgaW52b2x2ZSB0aGUgZGlyZWN0bHkgcmVsYXRlZCBzdWJzeXN0ZW0gaW4gZnV0dXJlIGJ1
ZyByZXBvcnRzLg0KDQpGcm9tIHRoZSBkaXNjdXNzaW9uLCBpdCBhcHBlYXJzIHRoYXQgdGhlIHJv
b3QgY2F1c2UgbWlnaHQgaW52b2x2ZSBzcGVjaWZpYyBwcmludGsgb3IgQlBGIG9wZXJhdGlvbnMg
aW4gdGhlIGdpdmVuIGNvbnRleHQuIFRvIGNsYXJpZnkgYW5kIHBvc3NpYmx5IGF2b2lkIHNpbWls
YXIgaXNzdWVzIGluIHRoZSBmdXR1cmUsIGFyZSB0aGVyZSBndWlkZWxpbmVzIG9yIGJlc3QgcHJh
Y3RpY2VzIGZvciB3cml0aW5nIEJQRiBwcm9ncmFtcy9ob29rcyB0aGF0IGludGVyYWN0IHdpdGgg
dHJhY2Vwb2ludHMsIGVzcGVjaWFsbHkgdGhvc2UgcmVsYXRlZCB0byBzY2hlZHVsZXIgZXZlbnRz
LCB0byBwcmV2ZW50IHN1Y2ggZGVhZGxvY2tzPw0KDQpQLlMuIEkgZm91bmQgYSBwcmlvciBkaXNj
dXNzaW9uIGhlcmU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi9DQU5wbWpOUHJIdjU2V3Zj
X05id2hvR0VVMVpuT2VwV1hUMkFtRFZWanVZPVI4bjJYUUFAbWFpbC5nbWFpbC5jb20vVC8uIEhv
d2V2ZXIsIHRoZXJlIGFyZSBubyBtb3JlIHVwZGF0ZXMuDQoNClRoYW5rcywNCkJvbmFuDQoNCu+7
v09uIDIwMjQvMTEvMjUsIDExOjQ1LCAiU3RldmVuIFJvc3RlZHQiIDxyb3N0ZWR0QGdvb2RtaXMu
b3JnIDxtYWlsdG86cm9zdGVkdEBnb29kbWlzLm9yZz4+IHdyb3RlOg0KDQoNCi0gRXh0ZXJuYWwg
RW1haWwgLQ0KDQoNCg0KDQoNCg0KT24gU3VuLCAyNCBOb3YgMjAyNCAyMjozMDo0NSAtMDUwMA0K
U3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmcgPG1haWx0bzpyb3N0ZWR0QGdvb2Rt
aXMub3JnPj4gd3JvdGU6DQoNCg0KPiA+ID4gQWNrLiBCUEYgc2hvdWxkIG5vdCBiZSBjYXVzaW5n
IGRlYWRsb2NrcyBieSBkb2luZyBjb2RlIGNhbGxlZCBmcm9tDQo+ID4gPiB0cmFjZXBvaW50cy4N
Cj4gPg0KPiA+IEkgc2Vuc2Ugc28gbXVjaCBCUEYgbG92ZSBoZXJlIHRoYXQgaXQgZGltaW5pc2hl
cyB0aGUgYWJpbGl0eSB0byByZWFkDQo+ID4gc3RhY2sgdHJhY2VzIDopDQo+DQo+IFlvdSBrbm93
IEkgbG92ZSBCUEYgOy0pIEkgZG8gcmVjb21tZW5kIGl0IHdoZW4gSSBmZWVsIGl0J3MgdGhlIHJp
Z2h0DQo+IHRvb2wgZm9yIHRoZSBqb2IuDQoNCg0KQlRXLCBJIHdhbnQgdG8gYXBvbG9naXplIGlm
IG15IGVtYWlsIHNvdW5kZWQgbGlrZSBhbiBhdHRhY2sgb24gQlBGLg0KVGhhdCB3YXNuJ3QgbXkg
aW50ZW50aW9uLiBJdCB3YXMgbW9yZSBhYm91dCBQZXRlcidzIHJlc3BvbnNlIGJlaW5nDQpzbyBz
aG9ydCwgd2hlcmUgdGhlIHN1Ym1pdHRlciBtYXkgbm90IHVuZGVyc3RhbmQgaGlzIHJlc3BvbnNl
LiBJdCdzIG5vdA0KdXAgdG8gUGV0ZXIgdG8gZXhwbGFpbiBoaW1zZWxmLiBBcyBJIHNhaWQsIHRo
aXMgaXNuJ3QgaGlzIHByb2JsZW0uDQoNCg0KSSBmaWd1cmVkIEkgd291bGQgZmlsbCBpbiB0aGUg
Z2FwLiBBcyBJIGZlYXIgd2l0aCBtb3JlIHBlb3BsZSB1c2luZyBCUEYsDQp3aGVuIHNvbWUgYnVn
IGhhcHBlbnMgd2hlbiB0aGV5IGF0dGFjaCBhIEJQRiBwcm9ncmFtIHNvbWV3aGVyZSwgdGhleQ0K
dGhlbiBibGFtZSB0aGUgY29kZSB0aGF0IHRoZXkgYXR0YWNoZWQgdG8uIElmIHRoaXMgd2FzIHRp
dGxlZCAiUG9zc2libGUNCmRlYWRsb2NrIHdoZW4gYXR0YWNoaW5nIEJQRiBwcm9ncmFtIHRvIHNj
aGVkdWxlciIgYW5kIHdhcyBzZW50IHRvIHRoZQ0KQlBGIGZvbGtzLCBJIHdvdWxkIG5vdCBoYXZl
IGFueSBpc3N1ZSB3aXRoIGl0LiBCdXQgaXQgd2FzIHNlbnQgdG8gdGhlDQpzY2hlZHVsZXIgbWFp
bnRhaW5lcnMuDQoNCg0KV2UgbmVlZCB0byB0ZWFjaCBwZW9wbGUgdGhhdCBpZiBhIGJ1ZyBoYXBw
ZW5zIGJlY2F1c2UgdGhleSBhdHRhY2ggYSBCUEYNCnByb2dyYW0gc29tZXdoZXJlLCB0aGV5IGZp
cnN0IG5vdGlmeSB0aGUgQlBGIGZvbGtzLiBUaGVuIGlmIGl0IHJlYWxseQ0KZW5kcyB1cCBiZWlu
ZyBhIGJ1ZyB3aGVyZSB0aGUgQlBGIHByb2dyYW0gd2FzIGF0dGFjaGVkLCBpdCBzaG91bGQgYmUN
CnRoZSBCUEYgZm9sa3MgdGhhdCBpbmZvcm0gdGhhdCBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMuIE5v
dCB0aGUgb3JpZ2luYWwNCnN1Ym1pdHRlci4NCg0KDQpDaGVlcnMsDQoNCg0KLS0gU3RldmUNCg0K
DQoNCg==

