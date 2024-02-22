Return-Path: <bpf+bounces-22490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2285F383
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E40E1F23AD3
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59236AF1;
	Thu, 22 Feb 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="U6pI99AO"
X-Original-To: bpf@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2117.outbound.protection.outlook.com [40.107.12.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC62C689;
	Thu, 22 Feb 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592014; cv=fail; b=GVg75KvIdYiCZZcRKijBvYbs2GXIGj6t4HChMJ31HEsrGEaaswY8LPBS9vYwKKVQKK0nyd9msqKtv4lp6mvr1IbcjgeoUvh1NDkw6QAbJTIqSmdo8GLP+8tC8fH0w4HJfovaXgb/1fJMP6y7AeC1jm2OxafRzb3amacXJcnVmxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592014; c=relaxed/simple;
	bh=+Mv40hEB3GhdRCS5PoolvUm+/9q7lLgKvoArkVELhGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tpDKPiNZkHTZ65sjklzAvGwXDAk0LtEWQjUViq8kAr/E0XYMqNCKG6hsMxgZlhTSMARNJoHGAvijOnw3ta7mUz1xfJEElSkukbWj63GJVRqgEKRC3fFAIm1ypI85z0ZgiU8cgEPBYxKtaPPKK+ovxvAh91wUDDt2VEsH2Aqav3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=U6pI99AO; arc=fail smtp.client-ip=40.107.12.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAckMZV4M2nsAz+cABU+F9JLX2b+n0tto8bRidYma3DIvReeGBduML7kXPo/nvLY8yI1kw5iUZ56kmutZZt/cRHUHNtxjYQiENwzxeSVM+1ME21WYuIt8hZYORSBZKl5k0ziJb+5BWeZLWgKcJGQbtAqulKBvBhQwW2TChj8LJyCehYGI86bwZS7Tqa6umqcrVDGzN0WdeK2TMcpaG9YwAgW/kzY1f8AWdijhTSII3rrRNM+5C/1aIWU0VysgFO7/y8BNEL7Zkl75Y0AfBt5siBOnxFl8Oy5kJcs0ifWp3j9J16kATJkC+X6CXlkJ4eKUj8DCF8TFeEzAMTbYWm3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Mv40hEB3GhdRCS5PoolvUm+/9q7lLgKvoArkVELhGg=;
 b=eruRqKGbYydHm1hSxpTPuPM4GLF/7Ye6k/5/NjPvtQrEVdUqD8QCC4agq49HG6qFK8p3oQFZI67WbAJLxUmMJuLz596M00CEZ4pYuqK6LvyNzK37uP6YRbPwm+yVY9maTuKusIik1YH/nrE1hqTBkySnLKUXFjQjaOQkJUx0/Rq5+12JBZXVHfWkjHQar6Ww674yIfMEe3Uw0McEm9FL+/47VlIn1EYpS8GijRnrNzyWHS6YqjUlLC/hyj7fFs23BDhl0hf+cYAk6U2LfqRtHfgOujn4/xnzY7r21tj8CnND6iX7WdNDuEx058Y7hZcAsbyrkOW9iw9sJdMvpGmmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mv40hEB3GhdRCS5PoolvUm+/9q7lLgKvoArkVELhGg=;
 b=U6pI99AOJFctSL4mWgLSFLxLatXh2Lpm294DmhG+dA9OVQE1HVfVpE/j5/WdfZFWh7WgROqINHuSUxMT+w7jNG1i7QbmiyKPrtK5iXNKDJHiOQf5lCGGuGpD+6gFmPbrhFgzENH0s214+ZQnXyARvAOmK5lZLOPUPwYnzZ/tz9072C1lnFeadB9KrAOOSHAjtzRHuWtX5qS/JviQrHYCvvLbVYAciYy/pnw6ZKKfb+PD+u8wjoOOXu4Y0eVLUmf3ay0ft7ZS1EAkPCet9jn5lTgkNCtZZ27z6WyI2kjnDKJsrowijlQvdD376dgRgfNO/2xIoF+b2+CewuFlcUgwzA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 08:53:29 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 08:53:29 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Daniel Borkmann <daniel@iogearbox.net>, Hengqi Chen
	<hengqi.chen@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "linux-hardening
 @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Thread-Topic: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Thread-Index: AQHaYljzfGfzNXs5T0S1aXyBr4+rcLEQ5HsAgABTnQCAA9qNAIABAd0A
Date: Thu, 22 Feb 2024 08:53:28 +0000
Message-ID: <d163fc82-7942-4a6f-a09e-59562e3f9d01@csgroup.eu>
References:
 <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <CAEyhmHT8H3AXyOKMc3eQSdM2+1UDETJDPyEQ0-AEb6E8pt9LTg@mail.gmail.com>
 <4d53e0f9-cfee-4877-8b56-9f258c8325f6@csgroup.eu>
 <2abc14fc-a19e-8205-c54f-a87c11ebd5be@iogearbox.net>
In-Reply-To: <2abc14fc-a19e-8205-c54f-a87c11ebd5be@iogearbox.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3320:EE_
x-ms-office365-filtering-correlation-id: 0a0c1c19-3d6c-4419-e635-08dc3383bd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UEU+5qVX46SIAtzKD8zDg5HeyYNtN58ZTYqVzeqq0fjeQJ3JmI1W8Aa6eq8i9hAl4zFpg3gAENZvJrZwP9b+aAz8B5TkDHWg8fhfE8Ga9Qc+FdgQ/iLJO4Vczjdyx2S4gpXetotAJ0HZI6nS+XDQUf5LtC8AXvqn2WD+bPzfLZE8asLfAEfmNegUhgeNRQG3gwSmVbeJMIn5xLVWOmI76bfB/P/YLfX2PiKZhShO3tcS1oG/Fm/1q1ajkCuy++tlEK/u54MYknlpp6d+1kg/x5g6mt/eu7uAa9kHJrHHWfP7WTpsUg6jS9p8iXJVVeeMo5YqMaAKzbostAfEOOF5jJC2QwF0mt3nb0n5FCkuBZGTGsYjCWGKcuu7xEvYdfDT8cuO48rogmZkXortsbmf+FUn4O7Onfbvcto78/cyCVSARAhAb127HTdH1bfmSDEBLmVkAWAddyjsQ5JfeOn4uCiZfXRuc6U3FSiJBdJEGTswsWn8E94Y7jMR+U68699LzlKPDxNMTyBw72j0qivnYRoVMHWRlCZxNxynKmnFdVat/1NjXixu+moqWlT+4ZIsipNLM4QGJxO+Fdq3aSVgfqUE9XpRjTU4kT1DL8DOtfE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2tDN2hjSmFmUlRRczhJZkw0UGIzdG9seVBVa3pqZ3BXWndiNzVlWkFES1R5?=
 =?utf-8?B?WUpHV3ZxeStUOU9SSFlCZlN1bE9aTVhkU1IvQlRBRTFlS083ZnFlZk9sUGhv?=
 =?utf-8?B?emFodVBVMUtzU3k2UUVJU3dyWTY2TFFjaUhCbFZleHMxRVdwMFlHaVlEWDI5?=
 =?utf-8?B?Ym9tbUplRW5rUTBMMnRrQzVNQjlGOERGSUQ4Vm85a2FTUEc0eUtvZ0c2S0J2?=
 =?utf-8?B?ZURxZ3Y5Qk8xKzRGVGJYUGJpWTcvRUZrODBpZEtnMHRmcjNOMkdyMzVKcy9G?=
 =?utf-8?B?K2s1eGhubFRheHhkSzd2a2FESXBWcGxYTjFDaHY3Q0h3Z29YSHMwenpLOVZF?=
 =?utf-8?B?a09QNFpRaDNQZCtHUE84dnRRTnFpTXBYSFM3SjBjZiswQitQcFhyZkZGZ1ZC?=
 =?utf-8?B?NGw1RFlrRlRONytnWU1DTDdkYWVVNG9yNGxPa2RtdktDY2VUbHhVYmxxV2VI?=
 =?utf-8?B?Z28zM1VVUU9keUpKbG9RSUlhVkZFd2trMWxZRFFxMWl1cDUwQUk3TzEvWHZL?=
 =?utf-8?B?dnZ6OXdPMVRxSU1vOVB3emN2WWJCQ1F1REtJK2R3TnNXcGhuZkhEWHpaMEJO?=
 =?utf-8?B?ZThtNWlHWEl0QVErQjhKSGNsS0kxcnhWQWoyWXlsTm9xTUdvcXVYOWcvOFQ3?=
 =?utf-8?B?NElNZ1VjSTNUd1FCK0w2TnJZcHFISmxkaEFiMGt0N3MwZGdaVTNrdVNJREkr?=
 =?utf-8?B?djhicWZ5WVN1TlJWYS9PQjZXSG9tYWNOQy95K1c1bzZhbWNWVTRmVUVUQlRa?=
 =?utf-8?B?ME9pOVlBYWdzSXpndXVhc2Z3d01FKzAwM3VMRStrUUw1c3d3Q2FTL1pGQzhG?=
 =?utf-8?B?Z0VNbEphU1lQRWNUbjFneWxmWUozMC9OdSs2WlpQZklEUklackJ5cXZQbXNQ?=
 =?utf-8?B?SXZaeHZrc1BDT1ppOUU4UmprSVpzbG81azRudlh3eWVuOVZUZjhpbWJ5QlR6?=
 =?utf-8?B?Y0V2OXBac3B3anBQemxhNGtuZTZPTTMzOVVLMEJyNTZkSU5yRk9ZRzBUZG5B?=
 =?utf-8?B?UVdWeHVIV2ZMSjdKdXFnejcrNzl5K2xyMzVBTDIyTEp4ekN6L2hNZ1B1NTN0?=
 =?utf-8?B?c1UzQ3hBeU82dVJEQmlHd3hHMGhqbHYrZy9qY3BDVko2K2VuT1Ezb0xCZUhY?=
 =?utf-8?B?K3RKSnFFc3NMOXlEV2RTWHZ5RzdvTUxUUTF1ejRHM1RJS3V0ZUxkYko5MmRY?=
 =?utf-8?B?cXdxRU1YSm5oWjhuZm5GRDFETXFjMURnZ0FzYTVGRTZpYjdzQndsZ1cxZlBH?=
 =?utf-8?B?bmJZamdxRXY4SkxPbnJKYW1WNk9NVEJtZXhvWlJqczU5a1Q2U3hwWUZpTjBO?=
 =?utf-8?B?UGdNQ0ZQN0JQWDVXa3BmS0JLVjdra0s1bzNxREdJV09LTmQ0SVhlUFRzOGVD?=
 =?utf-8?B?cFJ5SHlmMWV5QXcxcndBMnVqRTFDKzhQMENjQWthejNleVdSYXVmNVF3ZXF2?=
 =?utf-8?B?eTVJMzBaUkVUcWg5Y0NYRVhoY1p6L2dzVXFZUEdPM0dwcURza0czT0Z2aC9q?=
 =?utf-8?B?QVBtQ2NFcEpzcFJEOUd4KytVNXM1QU82Z1pHbUc5ck5TckhWRWhuQ01WNm5F?=
 =?utf-8?B?NmRTbXpNWlZ2Sjd1c2VlNklQSDNxZXlkUFQvTmNnWW0ydHlZWHJ2ZjhyNlRD?=
 =?utf-8?B?RGltNVpWRUd2YzRVb3JkeVVQTHhUREQyNUFNTFZEWU1iS2xrTmRhK0dlV1k4?=
 =?utf-8?B?YTFyRVpVaGRGVFZPb0Q5bkpwbURSeXZWeXVJemhLZ3VmUDZGV0hSMHRyYzBG?=
 =?utf-8?B?ZXh2T2UwU2Izd0R6ZnFGQ0NibGRYWmQ5eFNCL053bzhzdmM3WUlDZEJGeVF6?=
 =?utf-8?B?WTE5OHUyckthVi94MEpRNnd3dXY1bGhPL1VXS214VmhjVkx5anlvMHFteXkr?=
 =?utf-8?B?RDR1c2QwK3ZFTjEwN2xaOXI1M1lqaCt6VEF1dGtXa0U2NTVJUGtjRzRreEF3?=
 =?utf-8?B?NnJ5RElTRlEzWkk4SHkrelhuM1RWN1h4Y2NrV1NqMjNyV3dXMTFUZzFJeGEr?=
 =?utf-8?B?dnlFSDhGaXo0YkpuUGJPajFIM1ZBN2xhQVdYR1FFVUhjQWx6SEdUWnBzUWFy?=
 =?utf-8?B?dnA4OWtMakFQNHlhMEYxVzllTVU1SEduK0IvQ2UvQmFMekxPZ2NFT2tUek1V?=
 =?utf-8?Q?mW5thUO0I+oPDRbHJJAKOQ9Jc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <089D918C40FBD34995BAF66180FBC3C3@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0c1c19-3d6c-4419-e635-08dc3383bd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:53:28.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AQQwtkInBLJVCROjUDDaQXjdZ1g2TfYHbnHmB3isBtdLzvGnD68L8breFUYarkoePIFcBjHH2JQ5GBAr0VBgbJfSj9mWlufAE3UfNMA+6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3320

DQoNCkxlIDIxLzAyLzIwMjQgw6AgMTg6MzAsIERhbmllbCBCb3JrbWFubiBhIMOpY3JpdMKgOg0K
PiBPbiAyLzE5LzI0IDc6MzkgQU0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pg0KPj4NCj4+
IExlIDE5LzAyLzIwMjQgw6AgMDI6NDAsIEhlbmdxaSBDaGVuIGEgw6ljcml0wqA6DQo+Pj4gW1Zv
dXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgaGVuZ3FpLmNoZW5AZ21h
aWwuY29tLiANCj4+PiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCDDoCAN
Cj4+PiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPj4+
DQo+Pj4gSGVsbG8gQ2hyaXN0b3BoZSwNCj4+Pg0KPj4+IE9uIFN1biwgRmViIDE4LCAyMDI0IGF0
IDY6NTXigK9QTSBDaHJpc3RvcGhlIExlcm95DQo+Pj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91
cC5ldT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IHNldF9tZW1vcnlfcm8oKSBjYW4gZmFpbCwgbGVhdmlu
ZyBtZW1vcnkgdW5wcm90ZWN0ZWQuDQo+Pj4+DQo+Pj4+IENoZWNrIGl0cyByZXR1cm4gYW5kIHRh
a2UgaXQgaW50byBhY2NvdW50IGFzIGFuIGVycm9yLg0KPj4+Pg0KPj4+DQo+Pj4gSSBkb24ndCBz
ZWUgYSBjb3ZlciBsZXR0ZXIgZm9yIHRoaXMgc2VyaWVzLCBjb3VsZCB5b3UgZGVzY3JpYmUgaG93
DQo+Pj4gc2V0X21lbW9yeV9ybygpIGNvdWxkIGZhaWwuDQo+Pj4gKE1vc3QgY2FsbHNpdGVzIG9m
IHNldF9tZW1vcnlfcm8oKSBkaWRuJ3QgY2hlY2sgdGhlIHJldHVybiB2YWx1ZXMpDQo+Pg0KPj4g
WWVhaCwgdGhlcmUgaXMgbm8gY292ZXIgbGV0dGVyIGJlY2F1c2UgYXMgZXhwbGFpbmVkIGluIHBh
dGNoIDIgdGhlIHR3bw0KPj4gcGF0Y2hlcyBhcmUgYXV0b25vbW91cy4gVGhlIG9ubHkgcmVhc29u
IHdoeSBJIHNlbnQgaXQgYXMgYSBzZXJpZXMgaXMNCj4+IGJlY2F1c2UgdGhlIHBhdGNoZXMgYm90
aCBtb2RpZnkgaW5jbHVkZS9saW51eC9maWx0ZXIuaCBpbiB0d28gcGxhY2VzDQo+PiB0aGF0IGFy
ZSB0b28gY2xvc2UgdG8gZWFjaCBvdGhlci4NCj4+DQo+PiBJIHNob3VsZCBoYXZlIGFkZGVkIGEg
bGluayB0byBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNw0KPj4gU2VlIHRo
YXQgbGluayBmb3IgZGV0YWlsZWQgZXhwbGFuYXRpb24uDQo+Pg0KPj4gSWYgd2UgdGFrZSBwb3dl
cnBjIGFzIGFuIGV4ZW1wbGUsIHNldF9tZW1vcnlfcm8oKSBpcyBhIGZyb250ZW5kIHRvDQo+PiBj
aGFuZ2VfbWVtb3J5X2F0dHIoKS4gV2hlbiB5b3UgbG9vayBhdCBjaGFuZ2VfbWVtb3J5X2F0dHIo
KSB5b3Ugc2VlIGl0DQo+PiBjYW4gcmV0dXJuIC1FSU5WQUwgaW4gdHdvIGNhc2VzLiBUaGVuIGl0
IGNhbGxzDQo+PiBhcHBseV90b19leGlzdGluZ19wYWdlX3JhbmdlKCkuIFdoZW4geW91IGdvIGRv
d24gdGhlIHJvYWQgeW91IHNlZSB5b3UNCj4+IGNhbiBnZXQgLUVJTlZBTCBvciAtRU5PTUVNIGZy
b20gdGhhdCBmdW5jdGlvbiBvciBpdHMgY2FsbGVlcy4NCj4gDQo+IEJ5IHRoYXQgbG9naWMsIGRv
bid0IHlvdSBoYXZlIHRoZSBzYW1lIGlzc3VlIHdoZW4gdW5kb2luZyBhbGwgb2YgdGhpcz8NCj4g
RS5nLiB0YWtlIGFyY2hfcHJvdGVjdF9icGZfdHJhbXBvbGluZSgpIC8gYXJjaF91bnByb3RlY3Rf
YnBmX3RyYW1wb2xpbmUoKQ0KPiB3aGljaCBpcyBub3QgY292ZXJlZCBpbiBoZXJlLCBidXQgd2hh
dCBoYXBwZW5zIGlmIHlvdSBzZXQgaXQgZmlyc3QgdG8gcm8NCj4gYW5kIGxhdGVyIHRoZSBzZXR0
aW5nIGJhY2sgdG8gcncgZmFpbHM/IEhvdyB3b3VsZCB0aGUgZXJyb3IgcGF0aCB0aGVyZQ0KPiBs
b29rIGxpa2U/IEl0J3Mgc29tZXRoaW5nIHlvdSBjYW5ub3QgcmVjb3Zlci4NCj4gDQoNCmFyY2hf
cHJvdGVjdF9icGZfdHJhbXBvbGluZSgpIGlzIGhhbmRsZWQgdGhlcmUgDQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzg4M2M1YTI2ODQ4M2E4OWFi
MTNlZDYzMDIxMDMyOGE5MjZmMTZlNWIuMTcwODUyNjU4NC5naXQuY2hyaXN0b3BoZS5sZXJveUBj
c2dyb3VwLmV1Lw0KDQpJbiBjYXNlIHNldHRpbmcgYmFjayB0byBSVyBmYWlscyB0aGVyZSBpcyBu
b3Qgc2VjdXJpdHkgaXNzdWUsIHRoZSB0aGluZ3MgDQp3aWxsIGxpa2VseSBibG93IHVwIGxhdGVy
IHdpdGggYSB3cml0ZSBhY2Nlc3MgdG8gd3JpdGUgcHJvdGVjdGVkIG1lbW9yeSANCmJ1dCBpbiB0
ZXJtcyBvZiBzZWN1cml0eSB0aGF0J3Mgbm90IGEgcHJvYmxlbS4NCg==

