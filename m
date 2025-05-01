Return-Path: <bpf+bounces-57104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC9AA5978
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C547BACC5
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE232211A0D;
	Thu,  1 May 2025 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="LEwLhBl8";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JcMGx/0n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F42AF1D;
	Thu,  1 May 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746063767; cv=fail; b=uycsN2+uWZj0W3baL9upaSZXNPwzPt2fC+tqwz2bnHmR3r90GX9pQJk8rFBem8oQaGQBfwFHV9Gk/EWtxKdd/rhMq5gwXSQ0vByOq5NaifPMxZsm0eEkOfxZX3rznjsZarL/uhug4ZADVRBbJJ8Hqj5JwQHG4d5FiZ3Cr091W7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746063767; c=relaxed/simple;
	bh=5C7OHlC6W7h4dLMsyFrPCyjDUCvfJIQay7fh97wuils=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKw9nPGcq/I5I9EUALIUNxVCbdENK64qHmXWy/oHkk8Qtug+yZmY78RUu7mB10Dl9T2ArmUJDGRbPuLi03+5dzw/peRDvTMuC9Os3i9qKUH67UhaYWBeevJ85Q/sgpRSBsef6dZap7L/WJOMLdP6yrzwsk2uYjkC8Y+Jw/5BjOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=LEwLhBl8; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JcMGx/0n; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UI1Nnn022427;
	Wed, 30 Apr 2025 18:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=5C7OHlC6W7h4dLMsyFrPCyjDUCvfJIQay7fh97wui
	ls=; b=LEwLhBl8JEXbI8b8T/0GgEb0gm7kk7UuK3DvIva/Z3CXreRCOWn3H2nOd
	LRu2XTvysu6feE44wSG2mVF3HH8soTZ8kiNtvFFkvNmHTDNanIXITUTiz0ahBPWN
	SHY9OHYuB+DGFinjktM0QEfiGQRHhCP1ZhcAxzeWQ4uFxG+78fszY2tidsebY6r5
	/q/QOGdnD8oDSAYt+/odQApD2PKb4gEQCoAmDig0A1PqwUDZDPUi0ji4p0YhfoPb
	QtjjT0aDLMGkgXmD9UOBumiDk5ewW4vPBUKjD7BXqhYx+icDeKGhPKfTn+M5VPbM
	tqlzXsS0RT4esuUAM7XCH764JdGqA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8jfq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 18:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef5Hm9juuVCUosWbu4pqsWfGupSjFuyqIbTLEcCPZbty2JoFyRdCTBVvr861tmJasCQMlrBtX/WPpf66osJ7eq3npOVx5b/AU/M6b9ynv4sAp/YUdmV6+t+G9O04PS8tWQYKnQ0fhBkWmE5Rfi/cIdzioSZU4ywT9Pc0B5RKcBRXMBALHZA2Mmb4nr5mM1rRepc1rRAL++msTKpiheBkyT98Tuobr8qVQnGYjlpTQmkKS/J09PkkRwPpKy9huJvTwWWab9WbYNKxCYrjrMJNXC6ZHG+Qrkm89ypceerF5yIKE+j79N50YyaL1ylc03HQ2yTM2dggOTO0dyBCmjL2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C7OHlC6W7h4dLMsyFrPCyjDUCvfJIQay7fh97wuils=;
 b=OSmYk/d7rBWGr6bQPe/YSulJu8N1/9LVXW0Z7gMYEnUmQ1xl/6JQKXygG6xYjnGNLbDHFar26QCX9PpoJ7gnJbb6cJUbN5uEhRa/b0off3d2qlNIkYqfJ2Dc2H1HDGLHRN5pPj1N7CSkzF4alwNJheIRAME7YOs3IKq9EXtd6RpH6ECs8DTIW4yTslMPyfHvodJi2kIB7wbfLlevZ5pXJ2GUBAVUMtVUbdKkbmOJuX3XVYGqgkE3s9tif6PYISx5tMuZ0NZsgLA1bG/5KzX06msCvDew/BOxiYRq5/q3n/cJ2zqEIAejNn1xGXcypYlHOV6WWGDWSiaaHKQrkfPghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C7OHlC6W7h4dLMsyFrPCyjDUCvfJIQay7fh97wuils=;
 b=JcMGx/0nA1ukOUhl0IE44CpQvh+qYtqQq4Oi3ZZ+YeAawJ6isKN+wx0avrXOgztFr0YBWsXUHfM9+LiWrlDyIUJuE6ZAPs3TE9dpqviXe283Kxw/mUTi9FeADFUbn/ubPRqjra7zgtf4I9JD2wtVUbl8xrM9owG5B0OcQkXL8+7qF7CJbLTH3Dto994qTVJPpC5gAaEeSw5YmxEjhLo88Px/wz6nV+NCkVcRgNPjqcLIh8vzaq0Uks4gjXBkcO2TJG8ELnJAMQqUg2fS5FAEN0fhShU0lEfkkNWFPXgtfKid1t4BWN1PB6VnX/pgQ2YfgoUNZfb7+OBlZYoEDNlLug==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH7PR02MB9387.namprd02.prod.outlook.com
 (2603:10b6:510:275::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.14; Thu, 1 May
 2025 01:42:06 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 01:42:06 +0000
From: Jon Kohler <jon@nutanix.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon
 Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Topic: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Index: AQHbugfXMi2+AuBiuUeGEjm0tDyzm7O8tC4AgABArACAAAmHAIAAAf+A
Date: Thu, 1 May 2025 01:42:06 +0000
Message-ID: <3D448771-8354-46D0-BDFF-449FE1BD1B59@nutanix.com>
References: <20250430201120.1794658-1-jon@nutanix.com>
 <aBKReJUy2Z-JQwr4@mini-arch>
 <32FB9CF5-E5BB-4912-B76D-53971C6B6F98@nutanix.com>
 <aBLPtszlDe74yTlk@mini-arch>
In-Reply-To: <aBLPtszlDe74yTlk@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|PH7PR02MB9387:EE_
x-ms-office365-filtering-correlation-id: 907cc9b9-b24f-4e9b-e284-08dd88516156
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3RSV2dNc2FTN3lTN2RrLzFUU2pPMXpFaTJiTE0zVVRFTVZGalZubEt1OS9X?=
 =?utf-8?B?azVmMGxkVjZxc3RnYnFhM1dtTURBZkQveGc4T2xLYUFzYzkzMlpncU8xa0R5?=
 =?utf-8?B?RDBFSkhFaURjbVluNWk0ZjlOUXZGVGRnWEtyWXBDWDJINmV0ZHFKWjMzRVVy?=
 =?utf-8?B?SGFObVR4SFlUS21Wd29oK2R0RlhSZUFaQnlhZWhTVXdpU2VUdVozTFFjMG51?=
 =?utf-8?B?Y3c4MTZTbnVCRjhQY0Jqc2p1eTFNbTVnRjR5L2RVVnRwWi9uanpyb2YvMlk2?=
 =?utf-8?B?bHpaQ0pvTitYd3pTTkpVWFdJejZ2SFErWnJZZWdwaFBxcTFLemprRHF1cFBL?=
 =?utf-8?B?WWJjaDZvRmRLMXZNWlhhRXdIY21abnkxZ1QxSzBHSDRjVjVoYW83clNsRnJL?=
 =?utf-8?B?Snp3by90VFFPTXh3ODc5U0tnRFJYL2dJbkVGbERTM25lMjM5Q0U0aGdoZUs5?=
 =?utf-8?B?a3U3Y2oxMEUyN3ByQmVHajlTcGVNTGJjL1FVWEZsNjBoNlBRYUllMS9XNnN3?=
 =?utf-8?B?c2RNTXJYWTZTUko1cGtZc0lrbkdjRkFtUVpFSVJlcDVpR0ErNkU4Nzd4RnVG?=
 =?utf-8?B?SEJmbVVIWEdIYnN0d09DVFQwOW9xc2d6UTFEenFqbS9ES2hmSWJXengvL1g5?=
 =?utf-8?B?YWZRVFk3a0YrQU93eFFrVHFQeEVjSlVkcjlQcDVtcmFFN1ZtYVB0aTEydTRW?=
 =?utf-8?B?VTlMbUl4cS8xRHlNdmIzWlU3MmVQNENMR0FsUG5XNGhYbVdDL2I0RHZDQmJM?=
 =?utf-8?B?TkZNQ29acVlHSjdGWlp2UU5OWUdtTyt0K0ZGNzFxcjQ5WUp0Y0dMT3Q3ODFC?=
 =?utf-8?B?Zy9VREVZUGRXdDd2ZUhKbzlpRWY5TkcyMVRmV25qQ2swU2p3OGdpK3N0R1lO?=
 =?utf-8?B?bWVwNmpEQVZmdVMzUzN6dzlKcERqVEY0UFpZNnZwS2hJVXpUTGM5WlMvelps?=
 =?utf-8?B?MnR1aGljdEQwZkIrVVMvZFBLTVNuOUVHdWxMMXlXU2dpdCtleExNMVdzNjFL?=
 =?utf-8?B?bk90ZlladWFCOHZOVXVKbXZQT2F1MTJIV0FpejcyRUhCV1Y1Szl4RHlrRGxv?=
 =?utf-8?B?M1NBTHVrUHh3ZjZTRWtUMC9mb2liS3d0Q0ZOdnhYNXBRVXZ4WmNYWEFJS3RR?=
 =?utf-8?B?NnhmekxiK0graFFOMGpCWXZGUXdNU2FyOUlieEE2UXRMeERoMXlhV3lzYWU3?=
 =?utf-8?B?eUtKZmR6blhDenBrTHB4Mzg5V3FHNnptVHBqZnJvR04rc1JCU3B5ZXB5Z1Fp?=
 =?utf-8?B?NmxIZkFIUHd3YnVEKy9HN092WHNpRnRYZDFDL1dud1F2YWRHVEdvOHF2UUVR?=
 =?utf-8?B?Skhtak9EenJnK1B4V205elViR1BVYzBiNXJJTjF6N1R0di91c2R5TGJJSEI4?=
 =?utf-8?B?OHBUcFZIUHJibzVpWm5laVpDYzIrTERZdkIwY1Flc1ZJZ3JrSHBhSllDR0JC?=
 =?utf-8?B?QzJQZERJbUloZFNvcHFCUFh4SktFdUlrNlBzYlFQY3NYZm9jRWJuUEJCbURJ?=
 =?utf-8?B?cTRRQ3pza25XRS8wZUFYQTRwNE5FNEY2U0k0blN2bHMwMFI4Sk14NVZLUG93?=
 =?utf-8?B?RFF1SXR6dHpZaDU2M1JGdGN4ZDZuOWRXbVZUZDRVZTVpcTNNcjVtSndiQWVw?=
 =?utf-8?B?dmExN3FHQm5rOWgwN2dROFZzY0MvekNNb0VXUGVMbFlKSEVRUWU2K0JkMUNi?=
 =?utf-8?B?Y1BtcFl3KzhOcWNwTEVNTTJOZDlLVTExRkZNQUVTazU0ZEVWdEorckJvY2h2?=
 =?utf-8?B?N0JiQkhWVEg0S1dNa0U4bitoL1RjbHgwa2MyRHN2cVdIN0xNaWxnd2toNzN1?=
 =?utf-8?B?bmN0dVJNZmxJQWt1LzI3cVpMcnFvbG5XQVB5MkNTbDVtb3kzdXR6V1pxM0Z1?=
 =?utf-8?B?eWczbG9DbUNESGlzRHoxZEpaaEtUWWRuQnJpUkEyWHhsdWtoZDRoU2hRMXRQ?=
 =?utf-8?B?QTFKbGhSUzZpQ0paYWpVd2lqSG5SZGtWYVpuS09XWGxyd3ZKZ0g2UkF1S2hr?=
 =?utf-8?Q?7AhhPT1hmKhDa0WzibBLo5Wtf0WJzE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWRsdWFJSHRuUjRoME5kUjU3M0lObHlwblJxbzlLVkhucWhmaUI3U1UwOTh3?=
 =?utf-8?B?NHFydGhTQlEyWVdxVytvODBFTlIrd0IxVXNaNGJVZi95VWRkSGsybWNhMHVl?=
 =?utf-8?B?ZGw3NE9aQWtPblMwWkllQ0s4SkZORDBnNmhSMU9FU082M1k4cTZMTzFaRm5l?=
 =?utf-8?B?bGZtSkhQWW5GbzlEQnd3NzdHMGhnKzM2em1zRmhxUlNYWDRqTERIOWVNSVlu?=
 =?utf-8?B?Z2h3L2JhS0Z1MkFpcEZLZ0Q0R3RuK1V4V0FYZ21yU2VsS0V2UHdnRjIzTm9w?=
 =?utf-8?B?eHZVbzdoeVVGOFJTUk13SGo4UXh3N0gyaERWaDRaWU8reHRvVGlXcGNJSjg4?=
 =?utf-8?B?NXRiZW5najFZRlM4OVkvTENyUkUrWWdGVUd1THY0R1gzN0Z5aVliZDFNbDFZ?=
 =?utf-8?B?SWRudlNMRmROTGxDZ255ODFUeXJscWp5L1ROUHFQelVNSGE1SVpxbWJ0a2FV?=
 =?utf-8?B?NjdBNXp1Wi8yeTJjR0M5Z04vZm9KbUQyVW8vSE42cFBmWldSOWpUZFFoOHY2?=
 =?utf-8?B?VFdFOEREdXoxNUNBRmYxOU9LVHdzQWpia0ZJMTVEa3l1ZVdRRXdlTW5STDYr?=
 =?utf-8?B?V2FITzNIQnRPbVh5aHo4VWE4bGdKSk1QaUpZQmluNkZ5STh3Vzc3ZzQwaU5R?=
 =?utf-8?B?a25EK0ppdUZUSk1jY2t4M21pQjBzMHFhdjFxUEtwMFZLYk1PYy84MWxDaHph?=
 =?utf-8?B?MkVZYkFzY1g1U2xzZXpVRTdPRlB3N3NwdnZNaWZNMW5oanJvUXc2Tmk4Qm9F?=
 =?utf-8?B?Ykx4NVcrdC9Oa2JNV2VRdUxBWXdsNFlpbTJETCtyUC9yL2d3N0l0aUNuS25x?=
 =?utf-8?B?cnlCYVhTMUtDWWRYL0tmbWRSUmtBV1Iya3o3L2h5OXBBN0laYkhYQ05tVFZz?=
 =?utf-8?B?N3dIRDE1dnI2Q0tGdURxdlQxbHlRSCswaEZmdzZITGhaZU9adUxlUzNqOVV2?=
 =?utf-8?B?U3dYMFY0Y2tsQy9OMHMwQjF3NCtCVkxPRmc4SnhCTkc3WUs5UzNWcW9EQ0xu?=
 =?utf-8?B?eTZxU2J4K1hYR3E2VnF2a3h2bG8yR0lzRU9nWUkremlTdXgvQVk2U0ZnekUy?=
 =?utf-8?B?TE8welRqWFRlcEFBcWx0WHRNWnZ3NlozcVhEaVlRZE5CKzl0V2RGK1pHK1l0?=
 =?utf-8?B?OExpTDBLdGFPOEY4ZnM0RFlqYWJZZVc1OHBUbDNvVitYcUVTQmFFcm5wOTRY?=
 =?utf-8?B?YUl6ZXg3NDdvTTUrMythZ29DOUJ3bEhkd2s4VExrYVJtbm9KUDZYVysyY0pn?=
 =?utf-8?B?MWl1VTNLVXVPcTNjWVdaTHBGT1VVU0RZU3VRNndTNGFkd0l4RWtVUjJEZThJ?=
 =?utf-8?B?Q2FKd0NzSU5Bei8rL20wWHlQTDlYVW1mNkRjd0NscHZtcGFjc3VhVWhWeDVl?=
 =?utf-8?B?L1UyRXpCZlpyNjFITDdZajQ1bkY1cFBxQm9Fd29pVmY3Uk9iKzd4R3hBV1BS?=
 =?utf-8?B?UENqaHppNjhzSW9LQzh2bS8zeWR6MUp6NlEzQWwvYlBldmNWZ0daR08reGY4?=
 =?utf-8?B?eVVveHhtWXR2ZG1KbzM5eWRzN0kydHNNR0hLUGhhcDFYUzd6TVRCc3YzTmYz?=
 =?utf-8?B?Z1JKYkJmTEZ5emdDK1huZUhEblR5bDFpdjlsbmJGYlNsYTJ1K3RMVW5JLzZW?=
 =?utf-8?B?RENDUlFvc0ZOL3BDVFZsclNTTnRpTk9lT04wV3lJVTUzS0FvZlNzZXJFK251?=
 =?utf-8?B?clFqQ0dmeGFjN2RFRW5jaG8yZHRSWUNKOXcybFNndHd1d2duODdWdC94K3hU?=
 =?utf-8?B?aEFBOXJVWHdveEpFQ0lyYzhrMmFieldMU1BSeHBoWHI1dFl6QVNkd3N5MTVH?=
 =?utf-8?B?RWg2cCt1QXRKcjF6MzF3N0hvSElWc3cvTElqdmF3bWJydmQ1cFQybC83VDk2?=
 =?utf-8?B?ZUJsK3NZaGU5QjVqaytLVTFpTm9FcENUTmM3OTFvK0MySkViMnNlWk1qa2hR?=
 =?utf-8?B?NEFTYXRaRXJvTlEzcWRvTk50ZWFHUmpGNExwR2MvWUFBYm1GYndTNUFWWWtP?=
 =?utf-8?B?c1VTK2owNWdYU1V1ZGg4SEFUUnl5WmdHQ01ua2l1STVFNlpUdUpTN3ljTWc4?=
 =?utf-8?B?ZmIwemZrc2RtdjNlZThIMUVEKzg0UEh1YnNFNmpoL1dYb2JYSzdrclNPdE03?=
 =?utf-8?B?Zk9mVGxacGtRUXJWSU5nQzhpS0Zhb2RYa3F2MmJHODZndlBNL3RZZ0NtYVJB?=
 =?utf-8?B?UlZWazR1RHhVbk9ZUTZzTWFkamF2NDlHaXBHWGZ4RXo4T2czb1NoLzBxeFcz?=
 =?utf-8?B?RmV2RWJIajQ5TTFtQjQyZEptMGlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF72686AFBE4A46A71E9800FB50EF22@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907cc9b9-b24f-4e9b-e284-08dd88516156
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:42:06.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYw5sGwz4B5DR2oiITp+GxvM7Gx0kgySy8qIxYZfPi2tcQyeHFxkEQ+vP05mfWVx4mf4c/H1asynhsymNrz9QDeUqUJ5iRB19QlBYjFVZts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9387
X-Proofpoint-GUID: BXAu8XF0sioBEFmErokQwFBr_p0VX4uf
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=6812d179 cx=c_pps a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=pGLkceISAAAA:8 a=a5MsqxtKSSHlpW5CCQkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAxMiBTYWx0ZWRfX9VqizuedqkSn uNVHPF4xH4TwBnd9jemI1oi/eDYgDDDVa3MJPxsP5jk4/kV81r3hX4J5fFVtqQqSkCKvNlwnh1P 99pTNAC636oYdOC1e0bJk4mLZEz4hqNR6cUw5FEUKxRq3EKZMoHOEt3XBJxISZfVOzVHrGD7DSP
 h2lcDv3OMsH/Z6nRLz/VVicrfaVt95UqDUj8rnsUPLQSps91kdqzjOoChO4oWwcD/Ng18Vx7XPS NwW52/6ZilkJq0vvQp382+0tOfZgWu0JmcU7A8yyglvpb1VVsCWeXxP5wgdVCyqS4oJR6RmkCMa +2AOAkkBLT4aYjNeU+vvMof780yn11lE1hMVn0ND40sDwBCUco+y+zBb+RqDOqTsDzeVXBJIRQf
 UbuSRRiDgxEf33nM0n9C0f76RUwRsyovIxYKq3DA6hpQyyMs5HixTlvPbxEi2Z4f9RRSEJsN
X-Proofpoint-ORIG-GUID: BXAu8XF0sioBEFmErokQwFBr_p0VX4uf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDMwLCAyMDI1LCBhdCA5OjM04oCvUE0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICBDQVVU
SU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiAwNS8wMSwg
Sm9uIEtvaGxlciB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXByIDMwLCAyMDI1LCBhdCA1OjA5
4oCvUE0sIFN0YW5pc2xhdiBGb21pY2hldiA8c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4+IA0KPj4+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+IENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+Pj4g
DQo+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4gDQo+Pj4gT24gMDQvMzAsIEpvbiBLb2hsZXIgd3JvdGU6
DQo+Pj4+IEludHJvZHVjZSBuZXcgWERQIGhlbHBlcnM6DQo+Pj4+IC0geGRwX2hlYWRsZW46IFNp
bWlsYXIgdG8gc2tiX2hlYWRsZW4NCj4+Pj4gLSB4ZHBfaGVhZHJvb206IFNpbWlsYXIgdG8gc2ti
X2hlYWRyb29tDQo+Pj4+IC0geGRwX21ldGFkYXRhX2xlbjogU2ltaWxhciB0byBza2JfbWV0YWRh
dGFfbGVuDQo+Pj4+IA0KPj4+PiBJbnRlZ3JhdGUgdGhlc2UgaGVscGVycyBpbnRvIHRhcCwgdHVu
LCBhbmQgWERQIGltcGxlbWVudGF0aW9uIHRvIHN0YXJ0Lg0KPj4+PiANCj4+Pj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2VzIGludHJvZHVjZWQuDQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb24g
S29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiB2MS0+djI6IEludGVncmF0
ZSBmZWVkYmFjayBmcm9tIFdpbGxlbQ0KPj4+PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3BhdGNod29yay5rZXJuZWwub3JnX3Byb2plY3RfbmV0
ZGV2YnBmX3BhdGNoXzIwMjUwNDMwMTgyOTIxLjE3MDQwMjEtMkQxLTJEam9uLTQwbnV0YW5peC5j
b21fJmQ9RHdJQmFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPU5HUFJHR28zN21RaVNYZ0hL
bTVyQ1EmbT05cGR4elFzelhfTTBLM2dFUGVZT3lNWlpZU2tSUjhJTXZ4c2xTODMyMEVvY3RrNTh5
LUVMQ2RaNWlhcnlGMkdIJnM9Si1JTEI3RTlWUV9wbG8waHlqRXR6R3pqeTZHMF9vNE1NTW1tRV96
OHZ2YyZlPSANCj4+Pj4gDQo+Pj4+IGRyaXZlcnMvbmV0L3RhcC5jIHwgIDYgKysrLS0tDQo+Pj4+
IGRyaXZlcnMvbmV0L3R1bi5jIHwgMTIgKysrKystLS0tLS0NCj4+Pj4gaW5jbHVkZS9uZXQveGRw
LmggfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0K
Pj4+PiBuZXQvY29yZS94ZHAuYyAgICB8IDEyICsrKysrLS0tLS0tDQo+Pj4+IDQgZmlsZXMgY2hh
bmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdGFwLmMgYi9kcml2ZXJzL25ldC90YXAuYw0KPj4+PiBpbmRl
eCBkNGVjZTUzOGYxYjIuLmE2MmZiY2E0YjA4ZiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9u
ZXQvdGFwLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdGFwLmMNCj4+Pj4gQEAgLTEwNDgsNyAr
MTA0OCw3IEBAIHN0YXRpYyBpbnQgdGFwX2dldF91c2VyX3hkcChzdHJ1Y3QgdGFwX3F1ZXVlICpx
LCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4+Pj4gc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4+Pj4g
aW50IGVyciwgZGVwdGg7DQo+Pj4+IA0KPj4+PiAtIGlmICh1bmxpa2VseSh4ZHAtPmRhdGFfZW5k
IC0geGRwLT5kYXRhIDwgRVRIX0hMRU4pKSB7DQo+Pj4+ICsgaWYgKHVubGlrZWx5KHhkcF9oZWFk
bGVuKHhkcCkgPCBFVEhfSExFTikpIHsNCj4+Pj4gZXJyID0gLUVJTlZBTDsNCj4+Pj4gZ290byBl
cnI7DQo+Pj4+IH0NCj4+Pj4gQEAgLTEwNjIsOCArMTA2Miw4IEBAIHN0YXRpYyBpbnQgdGFwX2dl
dF91c2VyX3hkcChzdHJ1Y3QgdGFwX3F1ZXVlICpxLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4+
Pj4gZ290byBlcnI7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+IC0gc2tiX3Jlc2VydmUoc2tiLCB4ZHAt
PmRhdGEgLSB4ZHAtPmRhdGFfaGFyZF9zdGFydCk7DQo+Pj4+IC0gc2tiX3B1dChza2IsIHhkcC0+
ZGF0YV9lbmQgLSB4ZHAtPmRhdGEpOw0KPj4+PiArIHNrYl9yZXNlcnZlKHNrYiwgeGRwX2hlYWRy
b29tKHhkcCkpOw0KPj4+PiArIHNrYl9wdXQoc2tiLCB4ZHBfaGVhZGxlbih4ZHApKTsNCj4+Pj4g
DQo+Pj4+IHNrYl9zZXRfbmV0d29ya19oZWFkZXIoc2tiLCBFVEhfSExFTik7DQo+Pj4+IHNrYl9y
ZXNldF9tYWNfaGVhZGVyKHNrYik7DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4u
YyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+Pj4+IGluZGV4IDdiYWJkMWU5YTM3OC4uNGM0N2VlZDcx
OTg2IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYw0KPj4+PiArKysgYi9kcml2
ZXJzL25ldC90dW4uYw0KPj4+PiBAQCAtMTU2Nyw3ICsxNTY3LDcgQEAgc3RhdGljIGludCB0dW5f
eGRwX2FjdChzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLCBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9n
LA0KPj4+PiBkZXZfY29yZV9zdGF0c19yeF9kcm9wcGVkX2luYyh0dW4tPmRldik7DQo+Pj4+IHJl
dHVybiBlcnI7DQo+Pj4+IH0NCj4+Pj4gLSBkZXZfc3dfbmV0c3RhdHNfcnhfYWRkKHR1bi0+ZGV2
LCB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhKTsNCj4+Pj4gKyBkZXZfc3dfbmV0c3RhdHNfcnhf
YWRkKHR1bi0+ZGV2LCB4ZHBfaGVhZGxlbih4ZHApKTsNCj4+Pj4gYnJlYWs7DQo+Pj4+IGNhc2Ug
WERQX1RYOg0KPj4+PiBlcnIgPSB0dW5feGRwX3R4KHR1bi0+ZGV2LCB4ZHApOw0KPj4+PiBAQCAt
MTU3NSw3ICsxNTc1LDcgQEAgc3RhdGljIGludCB0dW5feGRwX2FjdChzdHJ1Y3QgdHVuX3N0cnVj
dCAqdHVuLCBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLA0KPj4+PiBkZXZfY29yZV9zdGF0c19y
eF9kcm9wcGVkX2luYyh0dW4tPmRldik7DQo+Pj4+IHJldHVybiBlcnI7DQo+Pj4+IH0NCj4+Pj4g
LSBkZXZfc3dfbmV0c3RhdHNfcnhfYWRkKHR1bi0+ZGV2LCB4ZHAtPmRhdGFfZW5kIC0geGRwLT5k
YXRhKTsNCj4+Pj4gKyBkZXZfc3dfbmV0c3RhdHNfcnhfYWRkKHR1bi0+ZGV2LCB4ZHBfaGVhZGxl
bih4ZHApKTsNCj4+Pj4gYnJlYWs7DQo+Pj4+IGNhc2UgWERQX1BBU1M6DQo+Pj4+IGJyZWFrOw0K
Pj4+PiBAQCAtMjM1NSw3ICsyMzU1LDcgQEAgc3RhdGljIGludCB0dW5feGRwX29uZShzdHJ1Y3Qg
dHVuX3N0cnVjdCAqdHVuLA0KPj4+PiAgICAgIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLCBpbnQgKmZs
dXNoLA0KPj4+PiAgICAgIHN0cnVjdCB0dW5fcGFnZSAqdHBhZ2UpDQo+Pj4+IHsNCj4+Pj4gLSB1
bnNpZ25lZCBpbnQgZGF0YXNpemUgPSB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhOw0KPj4+PiAr
IHVuc2lnbmVkIGludCBkYXRhc2l6ZSA9IHhkcF9oZWFkbGVuKHhkcCk7DQo+Pj4+IHN0cnVjdCB0
dW5feGRwX2hkciAqaGRyID0geGRwLT5kYXRhX2hhcmRfc3RhcnQ7DQo+Pj4+IHN0cnVjdCB2aXJ0
aW9fbmV0X2hkciAqZ3NvID0gJmhkci0+Z3NvOw0KPj4+PiBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9w
cm9nOw0KPj4+PiBAQCAtMjQxNSwxNCArMjQxNSwxNCBAQCBzdGF0aWMgaW50IHR1bl94ZHBfb25l
KHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+Pj4+IGdvdG8gb3V0Ow0KPj4+PiB9DQo+Pj4+IA0K
Pj4+PiAtIHNrYl9yZXNlcnZlKHNrYiwgeGRwLT5kYXRhIC0geGRwLT5kYXRhX2hhcmRfc3RhcnQp
Ow0KPj4+PiAtIHNrYl9wdXQoc2tiLCB4ZHAtPmRhdGFfZW5kIC0geGRwLT5kYXRhKTsNCj4+Pj4g
KyBza2JfcmVzZXJ2ZShza2IsIHhkcF9oZWFkcm9vbSh4ZHApKTsNCj4+Pj4gKyBza2JfcHV0KHNr
YiwgeGRwX2hlYWRsZW4oeGRwKSk7DQo+Pj4+IA0KPj4+PiAvKiBUaGUgZXh0ZXJuYWxseSBwcm92
aWRlZCB4ZHBfYnVmZiBtYXkgaGF2ZSBubyBtZXRhZGF0YSBzdXBwb3J0LCB3aGljaA0KPj4+PiAq
IGlzIG1hcmtlZCBieSB4ZHAtPmRhdGFfbWV0YSBiZWluZyB4ZHAtPmRhdGEgKyAxLiBUaGlzIHdp
bGwgbGVhZCB0byBhDQo+Pj4+ICogbWV0YXNpemUgb2YgLTEgYW5kIGlzIHRoZSByZWFzb24gd2h5
IHRoZSBjb25kaXRpb24gY2hlY2tzIGZvciA+IDAuDQo+Pj4+ICovDQo+Pj4+IC0gbWV0YXNpemUg
PSB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFfbWV0YTsNCj4+Pj4gKyBtZXRhc2l6ZSA9IHhkcF9tZXRh
ZGF0YV9sZW4oeGRwKTsNCj4+Pj4gaWYgKG1ldGFzaXplID4gMCkNCj4+Pj4gc2tiX21ldGFkYXRh
X3NldChza2IsIG1ldGFzaXplKTsNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25l
dC94ZHAuaCBiL2luY2x1ZGUvbmV0L3hkcC5oDQo+Pj4+IGluZGV4IDQ4ZWZhY2JhYTM1ZC4uMDQ0
MzQ1YjE4MzA1IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL25ldC94ZHAuaA0KPj4+PiArKysg
Yi9pbmNsdWRlL25ldC94ZHAuaA0KPj4+PiBAQCAtMTUxLDEwICsxNTEsNTYgQEAgeGRwX2dldF9z
aGFyZWRfaW5mb19mcm9tX2J1ZmYoY29uc3Qgc3RydWN0IHhkcF9idWZmICp4ZHApDQo+Pj4+IHJl
dHVybiAoc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqKXhkcF9kYXRhX2hhcmRfZW5kKHhkcCk7DQo+
Pj4+IH0NCj4+Pj4gDQo+Pj4+ICsvKioNCj4+Pj4gKyAqIHhkcF9oZWFkbGVuIC0gQ2FsY3VsYXRl
IHRoZSBsZW5ndGggb2YgdGhlIGRhdGEgaW4gYW4gWERQIGJ1ZmZlcg0KPj4+PiArICogQHhkcDog
UG9pbnRlciB0byB0aGUgWERQIGJ1ZmZlciBzdHJ1Y3R1cmUNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBD
b21wdXRlIHRoZSBsZW5ndGggb2YgdGhlIGRhdGEgY29udGFpbmVkIGluIHRoZSBYRFAgYnVmZmVy
LiBEb2VzIG5vdA0KPj4+PiArICogaW5jbHVkZSBmcmFncywgdXNlIHhkcF9nZXRfYnVmZl9sZW4o
KSBmb3IgdGhhdCBpbnN0ZWFkLg0KPj4+PiArICoNCj4+Pj4gKyAqIEFuYWxvZ291cyB0byBza2Jf
aGVhZGxlbigpLg0KPj4+PiArICoNCj4+Pj4gKyAqIFJldHVybjogVGhlIGxlbmd0aCBvZiB0aGUg
ZGF0YSBpbiB0aGUgWERQIGJ1ZmZlciBpbiBieXRlcy4NCj4+Pj4gKyAqLw0KPj4+PiArc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBpbnQgeGRwX2hlYWRsZW4oY29uc3Qgc3RydWN0IHhkcF9idWZmICp4
ZHApDQo+Pj4+ICt7DQo+Pj4+ICsgcmV0dXJuIHhkcC0+ZGF0YV9lbmQgLSB4ZHAtPmRhdGE7DQo+
Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gKy8qKg0KPj4+PiArICogeGRwX2hlYWRyb29tIC0gQ2FsY3Vs
YXRlIHRoZSBoZWFkcm9vbSBhdmFpbGFibGUgaW4gYW4gWERQIGJ1ZmZlcg0KPj4+PiArICogQHhk
cDogUG9pbnRlciB0byB0aGUgWERQIGJ1ZmZlciBzdHJ1Y3R1cmUNCj4+Pj4gKyAqDQo+Pj4+ICsg
KiBDb21wdXRlIHRoZSBoZWFkcm9vbSBpbiBhbiBYRFAgYnVmZmVyLg0KPj4+PiArICoNCj4+Pj4g
KyAqIEFuYWxvZ291cyB0byB0aGUgc2tiX2hlYWRyb29tKCkuDQo+Pj4+ICsgKg0KPj4+PiArICog
UmV0dXJuOiBUaGUgc2l6ZSBvZiB0aGUgaGVhZHJvb20gaW4gYnl0ZXMuDQo+Pj4+ICsgKi8NCj4+
Pj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHhkcF9oZWFkcm9vbShjb25zdCBzdHJ1Y3Qg
eGRwX2J1ZmYgKnhkcCkNCj4+Pj4gK3sNCj4+Pj4gKyByZXR1cm4geGRwLT5kYXRhIC0geGRwLT5k
YXRhX2hhcmRfc3RhcnQ7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gKy8qKg0KPj4+PiArICogeGRw
X21ldGFkYXRhX2xlbiAtIENhbGN1bGF0ZSB0aGUgbGVuZ3RoIG9mIG1ldGFkYXRhIGluIGFuIFhE
UCBidWZmZXINCj4+Pj4gKyAqIEB4ZHA6IFBvaW50ZXIgdG8gdGhlIFhEUCBidWZmZXIgc3RydWN0
dXJlDQo+Pj4+ICsgKg0KPj4+PiArICogQ29tcHV0ZSB0aGUgbGVuZ3RoIG9mIHRoZSBtZXRhZGF0
YSByZWdpb24gaW4gYW4gWERQIGJ1ZmZlci4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBBbmFsb2dvdXMg
dG8gc2tiX21ldGFkYXRhX2xlbigpLg0KPj4+PiArICoNCj4+Pj4gKyAqIFJldHVybjogVGhlIGxl
bmd0aCBvZiB0aGUgbWV0YWRhdGEgaW4gYnl0ZXMuDQo+Pj4+ICsgKi8NCj4+Pj4gK3N0YXRpYyBp
bmxpbmUgdW5zaWduZWQgaW50IHhkcF9tZXRhZGF0YV9sZW4oY29uc3Qgc3RydWN0IHhkcF9idWZm
ICp4ZHApDQo+Pj4gDQo+Pj4gSSBiZWxpZXZlIHRoaXMgaGFzIHRvIHJldHVybiBpbnQsIG5vdCB1
bnNpZ25lZCBpbnQuIFRoZXJlIGFyZSBwbGFjZXMNCj4+PiB3aGVyZSB3ZSBkbyBkYXRhX21ldGEg
PSBkYXRhICsgMSwgYW5kIHRoZSBjYWxsZXJzIGNoZWNrIHdoZXRoZXINCj4+PiB0aGUgcmVzdWx0
IGlzIHNpZ25lZCBvciBzdW5zaWduZWQuDQo+PiANCj4+IFRoZSBleGlzdGluZyBTS0IgQVBJcyBh
cmUgdGhlIGV4YWN0IHNhbWUgcmV0dXJuIHR5cGUgKEkgY29waWVkIHRoZW0gMToxKSwNCj4+IGJ1
dCBJIGhhdmUgYSBmZWVsaW5nIHRoYXQgd2XigJlyZSBuZXZlciBpbnRlbmRpbmcgdGhlc2UgdmFs
dWVzIHRvIGVpdGhlciBBKSBiZQ0KPj4gbmVnYXRpdmUgYW5kL29yIEIpIHdyYXAgaW4gc3RyYW5n
ZSB3YXlzPw0KPj4gDQo+Pj4gDQo+Pj4+ICt7DQo+Pj4+ICsgcmV0dXJuIHhkcC0+ZGF0YSAtIHhk
cC0+ZGF0YV9tZXRhOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+IHN0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgdW5zaWduZWQgaW50DQo+Pj4+IHhkcF9nZXRfYnVmZl9sZW4oY29uc3Qgc3RydWN0IHhkcF9i
dWZmICp4ZHApDQo+Pj4+IHsNCj4+Pj4gLSB1bnNpZ25lZCBpbnQgbGVuID0geGRwLT5kYXRhX2Vu
ZCAtIHhkcC0+ZGF0YTsNCj4+Pj4gKyB1bnNpZ25lZCBpbnQgbGVuID0geGRwX2hlYWRsZW4oeGRw
KTsNCj4+Pj4gY29uc3Qgc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2luZm87DQo+Pj4+IA0KPj4+
PiBpZiAobGlrZWx5KCF4ZHBfYnVmZl9oYXNfZnJhZ3MoeGRwKSkpDQo+Pj4+IEBAIC0zNjQsOCAr
NDEwLDggQEAgaW50IHhkcF91cGRhdGVfZnJhbWVfZnJvbV9idWZmKGNvbnN0IHN0cnVjdCB4ZHBf
YnVmZiAqeGRwLA0KPj4+PiBpbnQgbWV0YXNpemUsIGhlYWRyb29tOw0KPj4gDQo+PiBTYWlkIGFu
b3RoZXIgd2F5LCBwZXJoYXBzIHRoaXMgc2hvdWxkIGJlIHVuc2lnbmVkPw0KPj4gDQo+Pj4+IA0K
Pj4+PiAvKiBBc3N1cmUgaGVhZHJvb20gaXMgYXZhaWxhYmxlIGZvciBzdG9yaW5nIGluZm8gKi8N
Cj4+Pj4gLSBoZWFkcm9vbSA9IHhkcC0+ZGF0YSAtIHhkcC0+ZGF0YV9oYXJkX3N0YXJ0Ow0KPj4+
PiAtIG1ldGFzaXplID0geGRwLT5kYXRhIC0geGRwLT5kYXRhX21ldGE7DQo+Pj4+ICsgaGVhZHJv
b20gPSB4ZHBfaGVhZHJvb20oeGRwKTsNCj4+Pj4gKyBtZXRhc2l6ZSA9IHhkcF9tZXRhZGF0YV9s
ZW4oeGRwKTsNCj4+Pj4gbWV0YXNpemUgPSBtZXRhc2l6ZSA+IDAgPyBtZXRhc2l6ZSA6IDA7DQo+
Pj4gDQo+Pj4gXl4gbGlrZSBoZXJlDQo+PiANCj4+IExvb2sgYWNyb3NzIHRoZSB0cmVlLCBzZWVt
cyBsaWtlIG1vcmUgYXJlIHVuc2lnbmVkIHRoYW4gc2lnbmVkDQo+IA0KPiBUaGUgb25lcyB0aGF0
IGFyZSB1bnNpZ25lZCBhcmUgZWl0aGVyIGNhbGxpbmcgeGRwX2RhdGFfbWV0YV91bnN1cHBvcnRl
ZA0KPiBleHBsaWNpdGx5IChhbmQgaXQgZG9lcyA+IHRvIGNoZWNrIGZvciB0aGlzIGNvbmRpdGlv
biwgbm90IHNpZ25lZCBtYXRoKQ0KPiBvciBhcmUgcnVubmluZyBpbiB0aGUgZHJpdmVycyB0aGF0
IGFyZSBndWFyYW50ZWVkIHRvIGhhdmUgbWV0YWRhdGENCj4gc3VwcG9ydCAoYW5kLCBoZW5jZSwg
YWx3YXlzIGhhdmUgZGF0YV9tZXRhIDw9IGRhdGEpLg0KPiANCj4+IFRoZXNlIG9uZXMgdXNlIHVu
c2lnbmVkOg0KPj4geGRwX2NvbnZlcnRfemNfdG9feGRwX2ZyYW1lDQo+IA0KPiBUaGlzIHVzZXMg
eGRwX2RhdGFfbWV0YV91bnN1cHBvcnRlZA0KPiANCj4+IHZldGhfeGRwX3Jjdl9za2INCj4+IHhz
a19jb25zdHJ1Y3Rfc2tiDQo+PiBibnh0X2NvcHlfeGRwDQo+PiBpNDBlX2J1aWxkX3NrYg0KPj4g
aTQwZV9jb25zdHJ1Y3Rfc2tiX3pjDQo+PiBpY2VfYnVpbGRfc2tiICh0aGlzIGlzIHU4KQ0KPj4g
aWNlX2NvbnN0cnVjdF9za2JfemMNCj4+IGlnYl9idWlsZF9za2INCj4+IGlnYl9jb25zdHJ1Y3Rf
c2tiX3pjDQo+PiBpZ2NfYnVpbGRfc2tiDQo+PiBpZ2NfY29uc3RydWN0X3NrYg0KPj4gaWdjX2Nv
bnN0cnVjdF9za2JfemMNCj4+IGl4Z2JlX2J1aWxkX3NrYg0KPj4gaXhnYmVfY29uc3RydWN0X3Nr
Yl96Yw0KPj4gaXhnYmV2Zl9idWlsZF9za2INCj4+IG12bmV0YV9zd2JtX2J1aWxkX3NrYg0KPj4g
bWx4NWVfeHNrX2NvbnN0cnVjdF9za2INCj4+IG1hbmFfYnVpbGRfc2tiDQo+PiBzdG1tYWNfY29u
c3RydWN0X3NrYl96Yw0KPj4gYnBmX3Byb2dfcnVuX2dlbmVyaWNfeGRwDQo+IA0KPiBUaGVzZSBy
dW4gaW4gdGhlIGRyaXZlcnMgdGhhdCBzdXBwb3J0IG1ldGFkYXRhIChkYXRhX21ldGEgPD0gZGF0
YSkNCj4gDQo+PiB4ZHBfZ2V0X21ldGFsZW4NCj4gDQo+IFRoaXMgdXNlcyB4ZHBfZGF0YV9tZXRh
X3Vuc3VwcG9ydGVkDQo+IA0KPj4gVGhlc2Ugb25lcyBhcmUgcmVndWxhciBpbnQ6DQo+PiB4ZHBf
YnVpbGRfc2tiX2Zyb21fYnVmZg0KPj4geGRwX2J1aWxkX3NrYl9mcm9tX3pjDQo+PiB4ZHBfdXBk
YXRlX2ZyYW1lX2Zyb21fYnVmZg0KPj4gdHVuX3hkcF9vbmUNCj4+IGJ1aWxkX3NrYl9mcm9tX3hk
cF9idWZmDQo+IA0KPiBUaGVzZSBjYW4gYmUgY2FsbGVkIGZyb20gdGhlIGRyaXZlcnMgdGhhdCBz
dXBwb3J0IGFuZCBkb24ndCBzdXBwb3J0IA0KPiB0aGUgbWV0YWRhdGEsIHNvIGhhdmUgdG8gKGNv
cnJlY3RseSkgdXNlIGludC4NCj4gDQo+PiBQZXJoYXBzIGEgc2VwYXJhdGUgcGF0Y2ggdG8gY29u
dmVydCB0aGUgcmVndWxhcnMgdG8gdW5zaWduZWQsDQo+PiB0aG91Z2h0cz8NCj4gDQo+IFRha2Ug
YSBsb29rIGF0IHhkcF9zZXRfZGF0YV9tZXRhX2ludmFsaWQgYW5kIHhkcF9kYXRhX21ldGFfdW5z
dXBwb3J0ZWQuDQo+IFRoZXJlIGFyZSBjYXNlcyB3aGVyZSB4ZHAtPmRhdGEgLSB4ZHAtPmRhdGFf
bWV0YSBpcyAtMSAoYW5kIHRoZSBjYWxsZXJzDQo+IGNoZWNrIGZvciB0aGlzIGNvbmRpdGlvbiks
IHdlIGNhbid0IHVzZSB1bnNpZ25lZCB1bmNvbmRpdGlvbmFsbHkNCj4gKHVubGVzcyB3ZSB1c2Ug
eGRwX2RhdGFfbWV0YV91bnN1cHBvcnRlZCkuDQoNCkFoISBHb29kIGNhdGNoLCBhbmQgdGhhbmsg
eW91IGZvciBoZWxwaW5nIG1lIHRvIHVuZGVyc3RhbmQgdGhhdCwNCkkgYXBwcmVjaWF0ZSBpdC4g
QWJvdXQgdG8gdHVybiBpbiBmb3IgdGhlIGV2ZW5pbmcsIHdpbGwgd2FpdCBmb3IgYW55IG1vcmUN
CmNvbW1lbnRzIGFuZCBJ4oCZbSBoYXBweSB0byBzZW5kIG91dCBhIHYzLg0KDQpPbmUgdGhvdWdo
dCBpcyB0aGF0IEkgc3R1bWJsZWQgdXBvbiB4ZHBfZ2V0X21ldGFsZW4gaW4gZmlsdGVyLmMuIEkg
d29uZGVyIGl0DQp3b3VsZCBtYWtlIHNlbnNlIHRvIHBpcmF0ZSB0aGF0IGxvZ2ljIGFuZCBtb3Zl
IGl0IGludG8geGRwLmg/IFRoYXQgbWlnaHQgYmUNCmEgc2ltcGx5IHNvbHV0aW9uIGhlcmUgdGhh
dCB3b3VsZCBhbGxvdyB1cyB0byBrZWVwIHVuc2lnbmVkIGxpa2UgU0tCIEFQST8NCg0KSGFwcHkg
dG8gdGFrZSBmZWVkYmFjayBlaXRoZXIgd2F5LiANCg0KQ2hlZXJzLA0KSm9uDQoNCg==

