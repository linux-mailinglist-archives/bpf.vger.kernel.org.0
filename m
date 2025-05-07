Return-Path: <bpf+bounces-57692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E2AAE826
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B64E9C7AF5
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0C28D8D1;
	Wed,  7 May 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jlvtWah6";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ho8UO5Jb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5828937E;
	Wed,  7 May 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640100; cv=fail; b=PYbSwWe4xWoep4I/9me7v8OxR+uVQpftk3/o1/9bDQIqRlbXOpi/pcZPeJmZrYhuiaFTa4ysEVydSjYEpUrRBeHtQB2UqrXl/rg+Wz8Is9pwNaoUuqYJ8a52lUFSbLZ8aqzgsrLbS2OrPNvaVNa3l136hMhm/2ZStQJ9xdmuWB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640100; c=relaxed/simple;
	bh=oz5dnEFmfXYocZD0a6VkS2NrhxXO2XBsNmHAlGu2Eus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9vLg+hgctBi/4/m8tZmE2dKB+dsvC7wWmcrne6cqYIOkpkIJGDovAhCM3Qq5x8Zuox2uP0MkmS1551WQ58pZmJk8j8SfeG9ef4blIot3jHvhyDhMUu36QAUYzqLmTKGVSu9mriPqZ/TWygsfj5HofBZJIb7qf8zHB23sWG82/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=jlvtWah6; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ho8UO5Jb; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5478bHKK002585;
	Wed, 7 May 2025 10:47:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=oz5dnEFmfXYocZD0a6VkS2NrhxXO2XBsNmHAlGu2E
	us=; b=jlvtWah6TTDG/szRY4TDKBUqUxgpG3vijrktelk4BxmPrzd3dK2OnbDYe
	QhGnBWFFL1GBCYwcCq+cGV7FHhSdJDKPwid2SBxyjNEtUSJJomjKfHNh62dYp3AY
	W4zu4vyb8uLqxNSfQfa3dhG83YsAZb9Iqjii4WDkHXrywpwG2twT5fTr9DK+TB1x
	77QB3ARbuy8GtnAzEYX4gUKEzMZU5i3C10YhNOzwgoqJjWczAcJI93qmuVSVqBOa
	CxpvUdW2Uosd7A5DCSadvtF6kzNMilJDlR62hVfVRlUqGk6KxbQhKMfLJMT/oNS/
	rJTRA4zHSvGXqIpCPKjzhlIc0onww==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dffusgg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 10:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clGdVFsOpFx6B+nOduP1ajNswSKhTu7eSJ8fSbsy2tg1pCZ1gnscb2c5Rkdf/4QowNmOfznX3vBupX5MI9pLMWWaimKo1/yGNIpCLkr0sl/NrrRFEos5TwWruf2lDtjIk2Kn2NP5O7bYgyWPBN0h0M8rY6/FigHxpiwxZoqRJYvFj9Aa4zvN5X1dyWfAwmLYKrOSWyhQHmJVdnQx0J+IiL1m2MVax4pkdBlzwdJhnKik6ScQEDFKRyB6HiQkeCxELgv0Rgy6RqwEzmiiWipUSB22QFwPO19RghtIvpHoY4ku1EouA4+QK05H88tnAG8gPDqlx0KI7kBWjN+oV0ZaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz5dnEFmfXYocZD0a6VkS2NrhxXO2XBsNmHAlGu2Eus=;
 b=l5sPu0m+yNWHbhQEXkfsMIAuqVbyIxVLvZviNqiL8ui4EBZ7drsFogL7Vco999HzfNUeobWnl/9pZhbSBspoOJehYPej/NB5RSoN1jhZFebX7NN2jPACGQQTelwiHGfH+ILzxxG5+Dtu3azAl52v/bysjn+g7ZjODIN3cAuzLyYG0IEtmqZ0ho6RxMyoqBqvIRhrfg5svk2XExV6haIkbSkUGAFMQE7CMZdNuPMpt4ImEZHGPMmojjpWqA5/iI703eWpnqTIyO63Tj9T3zrF8r6cNjrQVUtNQ/D6nu1sN5w+IVzBkBBlP4ZfaR7QJ8gwKQ1F42tyEckSMkGX0hR15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz5dnEFmfXYocZD0a6VkS2NrhxXO2XBsNmHAlGu2Eus=;
 b=ho8UO5JbKklF2wH0dSz6KO446Bh363v7AsA6atfnsFMa+SERX/QzQ2fz/E//CbqmE6Y3X2WBVPugb6HzoRjtk/2f8hRvU2fUSr41IdvH0kC+EqvX+PpxvE02hdmaEX6ilPtiIt7q6zuRPlyx/yVOIGPI6GZmvgUkgjBVJf96XmYwdHeCgryrmiyv7MRyyrjlFDHEVl5o6xkj9vKVTBjdkHLTG2gpeNDbpZYou/TM/z2Yt4QeqVeSveX48LAre1iEBqNzykyOY9aMt7yo658VX9YWG5LyfvvVzbPyHQKyvuUTJS6FT2BU2OuNVgPRGwd9N6URDkOZgfsKoNpH6hl0Cw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by DM6PR02MB6528.namprd02.prod.outlook.com
 (2603:10b6:5:1bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 17:47:39 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 17:47:39 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jesper Dangaard Brouer <hawk@kernel.org>,
        Zvi Effron
	<zeffron@riotgames.com>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Jason
 Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jacob Keller
	<jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Topic: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Thread-Index:
 AQHbvoGOtDW/U9ulski7jan4/mWqq7PF36QAgAFLeACAADQMgIAAB1MAgAAB2wCAAAOsgIAABy6A
Date: Wed, 7 May 2025 17:47:39 +0000
Message-ID: <B4F050C6-610F-4D04-88D7-7EF581DA7DF1@nutanix.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
 <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
 <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|DM6PR02MB6528:EE_
x-ms-office365-filtering-correlation-id: 8adbdcdb-32eb-4be1-6b91-08dd8d8f42ba
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y0RFZG1YZUhJc2VLaHVyd1lkUTdRMlI3d3BmdUlzZm1EWjJ1Zmo0MkpLTkEx?=
 =?utf-8?B?TVBGdnBQb0tNbXp5TzFLazlTNmVTaDJCYS8rbDlqbnI5Si9ZZUw5OHloMzBm?=
 =?utf-8?B?QzhXSUxPRjdzUHFBVXJWbHQ2LzRDOEd1M1h5d2tBbU9xcCtpd20rMk1TUHJp?=
 =?utf-8?B?Q09nWFVZTmw1SDdhSSt3SjRWako5YTY2ZlU4ZFozaFgwNHV3KzBJR0k1QVJu?=
 =?utf-8?B?WGlPRXRBZ3JNc2FITWtqa1NKalRHNm9xZUllN0hkR0R4SEZvdUtueWRWbCtR?=
 =?utf-8?B?TG9WazNlOUZZK1ZGM1M3OXBVQzNLOElTTzQ2OGh0ZytjSDFyUk5HeXo5ZVRw?=
 =?utf-8?B?UFFqbFk0NEhiN2lHRFlZNk10bkJzRlU4TVJKV2JGVm8wYWd6R0grTXVoVmtw?=
 =?utf-8?B?SUpTeFhYbmp2YXVtYzlESURGZDdUT0JJc2gvOTVCTmhsejdOVlIveCtmMSt1?=
 =?utf-8?B?ZjkrcENrSEdnSHl6QnJUWS9GM2lvMnRLVVAxbU9aNTJqNGJNZS91QUpydVAr?=
 =?utf-8?B?VE9ZYU1xY2l4Y2RPcW1RSXFKb0FwSU9iK0hFRXBXdnQrdWRWZW04RVcrYy8y?=
 =?utf-8?B?cFRNbVdEeDEycGptRmZpcVFlNHpQTTluMFdUZDJSNENyajhTVitqb3JZSVhr?=
 =?utf-8?B?SjRTSXFpaDdOck5kaS9lRFBzQTJrQlN2WmVKNU5ON09GQTRuYmhtNmsxdG5X?=
 =?utf-8?B?YndaSnpNS1F1Z2ZJZlpVVUdGUkRpb3RLY25QeFVwZ3lwWXk0NXJxdDdPRjNz?=
 =?utf-8?B?OENGa0VySmQxVC9kaVRCbGYzeXVFVDFmRnFjbE02UFhjOTZ1VnE2K3VxVnVO?=
 =?utf-8?B?dmxNZTZnQjJ1UEpLRU1MdFJZOGRzSDgyVFhQM3FRYnJML0wyR3dEMDY4SHlq?=
 =?utf-8?B?SDBrWTYvMWJKSHduSGdKUmFMSXpRNXhNZ28vOHlNSnorRzBiVTVEMnZWck5m?=
 =?utf-8?B?VGdVRXNYUnRidmZnOUtpaFZ5RFZDMkFNbm9oS1J1MHlnNkxZWldyVEJiV2Ns?=
 =?utf-8?B?YzByTUg1U29VSDh3NmlnU0JkRmNNWWZKVW1OL3BzSGpRZkJORmI5SWZlYVkw?=
 =?utf-8?B?bjJvY3Z3RGF5Qk9nZjd4RElkV2R3RCtkL1lHRnlIRXJwNmI0YXBjZWkrbWpF?=
 =?utf-8?B?WWtvS25oQThwOHRWMWcvb2FnRlNtcG9oelk5VDVxQURIdTBUTzZJYjRDNExK?=
 =?utf-8?B?MmgzUzRFTlFQbU1IbnpBdTV2QWVWdHFIMGNUZEhKK3JFQmoyRTNVWWtJRlYz?=
 =?utf-8?B?OFhNY1RzWGhmaWFxVUJLdDM4WkRiYS9GcXgzQVcvc1BDeUNITzdiSm1WQXdl?=
 =?utf-8?B?MzQ2WTlKWDNFOVFDcytQL1o4ZXZzbkNsWlY3cHBEYnRlOWs2QjNTQzIxeDdE?=
 =?utf-8?B?UTA2eVZRU3dnZjN2a0kzVE9pSytXNUdJRXNJbk5jOE1tTEplMUpacnpiVVR6?=
 =?utf-8?B?WDhXaWxrYkJQSFRFQVRtZklJVFN0cWt3UUYrbk1oKzAzOHloTlFvQXpqVWQ5?=
 =?utf-8?B?Szd3RkFhaWJ0NENDZHlGSkJ4VVh5L21kdU82eTdGWWt5ZjhqY1VZTXRjN3pi?=
 =?utf-8?B?MU05RkM4NXVOUkhMNUt2N3Z2T2lQbjZVWDNObG0vYkUzK2ZPUGxrM2hQU2x4?=
 =?utf-8?B?OC81dVA2aDFsczEyaFBJOEFKcGFFOGVISWVtcDJycTNjN0ZXL05kN05VTUFt?=
 =?utf-8?B?SU9pSDlwVmRTQ1dsN01sZi9UTkUyWGUza1M0VFhWRDZLd2hCSjM4Tm82WWhE?=
 =?utf-8?B?MUNGV1FLb2RINFJlaGNGcmRkRjh6akgvUWN5d0dVV1pINzNiZkxTZ0xnZlZI?=
 =?utf-8?B?Tm1EdmZOYVJuNU9RZjNCQkZzVDhudzVTa0pwc0Z0ZURWN2JidUVSTWFaaWN3?=
 =?utf-8?B?Q2N2L1A3SGdWR2lkRnFPb1NyT0wxNi9DdDVCc2JDdFVpUUk1VnJJOGFJeXZz?=
 =?utf-8?B?dGNzTzQ1OXM4eGdETW1wbU05MHVUWVN4Nm9LRWcwNmhXbTR4TmNTVzdzNTNU?=
 =?utf-8?B?Q1hhbjR4OGtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFlwLzhPeFRobXZXMzV3R1hVT1JwQlJZVDlEZElVRG1wNXU5eUhSaEp2eUhu?=
 =?utf-8?B?TU9kTWpkSkVnS3YzTFlPOXZLbXdEeERKZHh5S2IyTWR6UXIrdUVqcXozOGs4?=
 =?utf-8?B?QVFjcTVhQkppUkhJZ2htZzlSWFY1cG9IaHE1V3d2Ylpxd0oyRnF3S0d4a3Rs?=
 =?utf-8?B?R3VuclMwcVRzMXczWWJhS1FHcW5MUzRzSDRiUzZ1MHFYTExEamFodmNiOWNW?=
 =?utf-8?B?SGlTVkxCd2FTQmtMTGR3bGN3TGxjbWh3dUxBYkp3dW5rRmlWSkZIQzQ4RXp0?=
 =?utf-8?B?UmJ2MHlOeFhwVEhlZHRTZlY2RnBaNGNWSHBncmZxa3REWkpnd1pYdjdYM2Mv?=
 =?utf-8?B?Mk5BeGhYQ1JyV3VkMDRkblluUHI0ZitaMHdqaWIxQkxZbC9JdnJwTFp3dWQ3?=
 =?utf-8?B?clczYnNRYUFrdU9PdFowT2IwVU4rOGFYQVJBVUJ5UTNUMHdpVVZ5SkgzeFIr?=
 =?utf-8?B?djFxVm1jTzJuTTVwRE8weEIrN2ZtZEcvZTA1YmZGWklVUDZCZ3hpbVltajls?=
 =?utf-8?B?RnR4UDc1Yy92ZWRXSUZ4OVJBVGFyd1FJa3lITjA3N0lHSGM3ZVlFVDFCc1Nj?=
 =?utf-8?B?bm91OVN1ZFpaKzFjb3RmVkoyL2tMOWpnUm00L3VnWnkzWlBlcFptSUoyVVZK?=
 =?utf-8?B?dXU3Rk9JTlplcTBucmRsMWpWblhVenI1STZGSStXdno1c1FKTkFFODNid3RL?=
 =?utf-8?B?QU5tVXVBZE5wSzVxcVNTY1J1aXpTbU5lcE5EcndON055SU1UbFU4MEJhOG9h?=
 =?utf-8?B?VGkvWkRuakNhQWFHLzVFOTNTVUE3dGlURU5scE80c0pDWm82YlVpUnQvNjhR?=
 =?utf-8?B?TXFpUjVoYllDU1plRkZjYlNLbTRRWndYallZSk05VFBiMzlBWjFZUGlocjNz?=
 =?utf-8?B?S3pGNHpzazkyTnVyNG1Oa21zSkZYSmFEN3g3YTZTcXI1M2tzNERGd3ZUYXdH?=
 =?utf-8?B?TDYyMjJBRXJUS2xrNDMxbERINTZlUFB2WE9iWlZBL1JtTWNpZ1c2VGJ4dnNO?=
 =?utf-8?B?c0RpWS85cWlmL1dJd1VuZXBpY2dwcGNUUGhOaGh0M3hXT0pnbURmaFkwOE5o?=
 =?utf-8?B?QTd3NGdHK0VKM1NYbDUvWjNVMTZZSzl0N2xBYlNjY3hobTJZWkQxQWtEZ3NM?=
 =?utf-8?B?K0gwRmNFQTVLa2VoZVIxOGpHbXpiTUwyOExacWhQU283c2xXdTl3eEYyaS9D?=
 =?utf-8?B?TVRNOEk1Y0VjRW1Od05jNlVrQ0ZpV0RUak1sZ2RoZXhwZFVkbVdWdEQzaURt?=
 =?utf-8?B?QXU1TGVHL3p3T0lTNllJSHZrTit2OGp6MWtTZTdvUGZneUhUakUyZnNNY21F?=
 =?utf-8?B?U2NQNTBsNUt5S0dMNE1Qc0pxYjZQelZVTlBlcVVxdVlFMjBMTUVyVUxraXY4?=
 =?utf-8?B?MW00M0lUalVTMXIrNGhqd1F2UlNUcmFWdFh5QjVETzNSdGk5N3JkVlRtWDBw?=
 =?utf-8?B?dTJmTHpJYnFQOWZOOUpicU5zdC9oODhUL2phYlRZSzVuZW9FZEhqWEdFMzRn?=
 =?utf-8?B?Q3ZvK1AxRVl1eWZ0Y3BTdXRyU2pkdXhidTNJdGVJczVZMHBPV2VuOUkrVmZ2?=
 =?utf-8?B?MDlJZkkxZUhSKzFibCsxQWR4QjhRTXFyOVhWR2FCN20vbEV3RGxZbEt4Rklu?=
 =?utf-8?B?aDdhR2ppS0d6akhjdmY1TW1ZSXRlOThIb0Zmdk00Z0tSVjR1NmlNN1d6cCtB?=
 =?utf-8?B?akRFS1BRVHk0TU1uM21CV3JPQlVxaVgyUkxqZHhERGEwR1ZRclozaWNkc0Rk?=
 =?utf-8?B?VitGbTBtV0hTLzFrK09KNEg3UlZBRktDa2ZhM1RvYTkwaVkwUnNKQis2TkQy?=
 =?utf-8?B?eXlFQTQ3NXdlYzJ3c3p6YXgzeEVhV21WNk9NcEZmc2FsSGRHVVI0UFNIY1A4?=
 =?utf-8?B?RkR0L2FDZElCRFZUem8xd0gvaW85WlQyek1oWGxlLythU1pVYk5BbGRaMkUx?=
 =?utf-8?B?Z1JZTDczMDZYWHM4a1hwbGhHbXh1bGp5TDQyanVBUnZQTUNjNjVMLzhyTVd2?=
 =?utf-8?B?NU04blpYSkk4WEpodlFHazZEeXhwYVFIOWlMUUtIVWhCR29SOGsrRlVoMHp0?=
 =?utf-8?B?Z1ZaQzVnSlFmYzVRN21lM2NNMTllSEFCRlF4bWFEZEY3ditkbEpUdmZkK0lu?=
 =?utf-8?B?VHJHVjV1NUEvRm91SEp2RnZFelhhYlRXT2E3NXo3S2JKZUFyOWRjb2ZuYmUx?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C330490AB931BC46B2012A02F92EADBC@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adbdcdb-32eb-4be1-6b91-08dd8d8f42ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 17:47:39.5589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjmdOizc5Xrgm91ZJPCESFTEGOvloAGE3el19zQa9VavhMC9ODDPO35B2OGkFn3NE3lkOcgI2Wy3BDBci/Oer6uF0PbpLfbPFa75c022CxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6528
X-Authority-Analysis: v=2.4 cv=WfYMa1hX c=1 sm=1 tr=0 ts=681b9cbf cx=c_pps a=BfiT+f4K8gVEfImFRIf1tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=0BuA0GhK-w2Ksjze8u4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YExKTSos-luf53hIeoxc6gj4yhR0V4tR
X-Proofpoint-ORIG-GUID: YExKTSos-luf53hIeoxc6gj4yhR0V4tR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1OSBTYWx0ZWRfXz5+1e/RJwx0Z L2EgH5EYC/FVc4eHnobf5NAgJovd9A0OQpWiY3V4QlohmwWyFNUeOxGo8Qv+ieAvJ6A3KdjqdsR gU86zjEqLCCGvhYoBIxH/nbu8y2K1zCmvdWL1+oY3uXxocbhLpSyFvXzqFXA55Gvq8+22KCdVTG
 90HIAw83yELYsGV2ISfEy3smKtlmHeetp1Iw9UJ7BkmDaJfCkH6tyU3ruBch1eSb3cRhQaRAtDA zdG+HWxyes0gPwaA4IaXFa5spcIUbZlPBN8B07HcO3JFLMykAJBmQ969PDpwtT6ldFgvmvMkJbd noszHP69ORIger+Jl3wvxvB3cKB1P7yRJ983wpCFh0wwARcu1zGgGVEO+57VQiXbuwa4h4/2Cp7
 Attvz1CfhZYL1cECvI3zHo8sX7l1gSFhKhyCQUZoregMH6bTkHc5khZgd8t+2Khat99+nA76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDE6MjHigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpl
c3BlciBEYW5nYWFyZCBCcm91ZXIgd3JvdGU6DQo+PiANCj4+IA0KPj4gT24gMDcvMDUvMjAyNSAx
OS4wMiwgWnZpIEVmZnJvbiB3cm90ZToNCj4+PiBPbiBXZWQsIE1heSA3LCAyMDI1IGF0IDk6Mzfi
gK9BTSBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
PiANCj4+Pj4gDQo+Pj4+IA0KPj4+PiBPbiAwNy8wNS8yMDI1IDE1LjI5LCBXaWxsZW0gZGUgQnJ1
aWpuIHdyb3RlOg0KPj4+Pj4gU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0KPj4+Pj4+IE9uIDA1
LzA2LCBKb24gS29obGVyIHdyb3RlOg0KPj4+Pj4+PiBJbnRyb2R1Y2UgbmV3IFhEUCBoZWxwZXJz
Og0KPj4+Pj4+PiAtIHhkcF9oZWFkbGVuOiBTaW1pbGFyIHRvIHNrYl9oZWFkbGVuDQo+Pj4+IA0K
Pj4+PiBJIHJlYWxseSBkaXNsaWtlIHhkcF9oZWFkbGVuKCkuIFRoaXMgImhlYWRsZW4iIG9yaWdp
bmF0ZXMgZnJvbSBhbiBTS0INCj4+Pj4gaW1wbGVtZW50YXRpb24gZGV0YWlsLCB0aGF0IEkgZG9u
J3QgdGhpbmsgd2Ugc2hvdWxkIGNhcnJ5IG92ZXIgaW50byBYRFANCj4+Pj4gbGFuZC4NCj4+Pj4g
V2UgbmVlZCB0byBjb21lIHVwIHdpdGggc29tZXRoaW5nIHRoYXQgaXNuJ3QgZWFzaWx5IG1pcy1y
ZWFkIGFzIHRoZQ0KPj4+PiBoZWFkZXItbGVuZ3RoLg0KPj4+IA0KPj4+IC4uLiBzbmlwIC4uLg0K
Pj4+IA0KPj4+Pj4+ICsgKiB4ZHBfaGVhZGxlbiAtIENhbGN1bGF0ZSB0aGUgbGVuZ3RoIG9mIHRo
ZSBkYXRhIGluIGFuIFhEUCBidWZmZXINCj4+PiANCj4+PiBIb3cgYWJvdXQgeGRwX2RhdGFsZW4o
KT8NCj4+IA0KPj4gWWVzLCBJIGxpa2UgeGRwX2RhdGFsZW4oKSA6LSkNCj4gDQo+IFRoaXMgaXMg
Y29uZnVzaW5nIGluIHRoYXQgaXQgaXMgdGhlIGludmVyc2Ugb2Ygc2tiLT5kYXRhX2xlbjoNCj4g
d2hpY2ggaXMgZXhhY3RseSB0aGUgcGFydCBvZiB0aGUgZGF0YSBub3QgaW4gdGhlIHNrYiBoZWFk
Lg0KPiANCj4gVGhlcmUgaXMgdmFsdWUgaW4gY29uc2lzdGVudCBuYW1pbmcuIEkndmUgbmV2ZXIg
Y29uZnVzZWQgaGVhZGxlbg0KPiB3aXRoIGhlYWRlciBsZW4uDQo+IA0KPiBCdXQgaWYgZGl2ZXJn
aW5nLCBhdCBsZWFzdCBsZXQncyBjaG9vc2Ugc29tZXRoaW5nIG5vdA0KPiBhc3NvY2lhdGVkIHdp
dGggc2ticyB3aXRoIGEgZGlmZmVyZW50IG1lYW5pbmcuDQoNCkJyYWluc3Rvcm1pbmcgYSBmZXcg
b3B0aW9uczoNCi0geGRwX2hlYWRfZGF0YWxlbigpID8NCi0geGRwX2Jhc2VfZGF0YWxlbigpID8N
Ci0geGRwX2Jhc2VfaGVhZGxlbigpID8NCi0geGRwX2J1ZmZfZGF0YWxlbigpID8NCi0geGRwX2J1
ZmZfaGVhZGxlbigpID8NCi0geGRwX2RhdGFsZW4oKSA/IChaaXZFLCBKZXNwZXJCKQ0KLSB4ZHBf
aGVhZGxlbigpID8gKFdpbGxlbUIsIEpvbkssIFN0YW5pc2xhdkYsIEphY29iSywgRGFuaWVsQikN
Cg0KDQo=

