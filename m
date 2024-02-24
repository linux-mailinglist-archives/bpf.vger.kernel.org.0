Return-Path: <bpf+bounces-22639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42867862364
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 09:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC341F230A5
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F117597;
	Sat, 24 Feb 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Tsf1jhGX"
X-Original-To: bpf@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2111.outbound.protection.outlook.com [40.107.12.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4A1400B;
	Sat, 24 Feb 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708762035; cv=fail; b=jx+jXmafFdC3OubyUNAVUby7hH8b7Q2eySTRR9+knUFvZKR2wg1rc6Nw4cFaujEMcpqZYOpALPGseL2tyLwDuW38Kr5OkWbwDuzHQH6X7TW9pkJB/MlJHDc9a86vtl5ixbnJ3r9ViwqZnlo/9phcJ0rEb/uxwsh5q+KNjCa1Spw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708762035; c=relaxed/simple;
	bh=IuTj59DiPzYYrz0kn/qr80PwXTRJSh2glX9DTy3KQ/o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ugocidAAmYyAock3/QMML58BM0z69TS1eV4MTtLiS6mRz17V/HQQp3gJyuKNB+47PLTueGVsINJ09/YHE/NG07BY6J5zxV31hMXSqCxB3B+Pi0KGPLk9d6g8jRiZCbc1Yzih7++h35WfbnF/PLx6evq+AyrsNwKOKekwiuPAiKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Tsf1jhGX; arc=fail smtp.client-ip=40.107.12.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZKenSb/Cu6WlkH5IlZ+vEId0dw7rEFr51sw/TVHMnwWiG4e5q4HYxS1mOpkW//42r+s7i4wLFJPYQGd3HEp6K2sYEpHJbUMre0CjlnalymldUlfYmYnZqNWtTcrjQWvFkLBDN4NlNPJdguaJ3zfbMbpPnWsC53qtllB/vbigQtwB8xxvL9J5QZOjSWkjYaszHwa8VxhTWAa8DDRi27sSaZq3DDMI6LNDf0QawMwfhHBfiZVwuw6WPy/DPjkFR48JogHJagrcq5pzOvsB7oZqCDBpBu8/Jg787x6mFvhP53zukmxCVIaRN9n7wNZ/PaDytqI+km9lHnFP7VQgSq2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuTj59DiPzYYrz0kn/qr80PwXTRJSh2glX9DTy3KQ/o=;
 b=T3FaZDI4pl1DgmxGPIWjT1iy6JuYdoks5dW3PMozwG291VuDeHzFdWNLfWRvLN7hX6aTWQ+hw3XwRhQoTdM+DzOZKs8HqTHHG4qIoHe4+d7+DwZb4pN/oUXp0SfpAj4gtIfv9xOOAxHCPfIJBwQ4B2boat9kkqqU4knf7KY2MvcERA6oMnIWUxxx61/SmPrHkZMBStTVG1dcInQAH7lXlvdvlfum3E1ZZ0fKvUBCB09uoea4d59uBSrW3P76vEBsp17qdNeJKdwcPIxhSE82dWVu5xPpbFDGQwQti4LD2m8oxj/csHZySzVwIJs3Nl94ZL4p+VsFKaf5niyN4DijPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuTj59DiPzYYrz0kn/qr80PwXTRJSh2glX9DTy3KQ/o=;
 b=Tsf1jhGXU0wvBdNEFUksKTfWoP0wL+UPhThMcSObJhF+9Se3MGHXsXgkb/oDA+8bhhahDp3RFkmj6Th2k5osLL0i9TK7IfNk8xQRyfzPSxgCLOMC7+EX2dZu5crKh/gm0IgbblgdfLD9Y0WWlsK7TV68ktKcrxjW48IJ/jqot6aaGp+aaYOwNF/76ng0DZxOlWmT7+l7wRZFY0ESgPJRIYHd58ccMCFkx0q7k1IPHe86WnOsfhIn32K6Z949Wjh3onzY8crLR9nyaDXxLIJrN7gVOkscMdIweGAPG9CDPO+h0I2rHnzgbw4UEZpvRLNq0u+f6DmBeQWc9bawFxNvDQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1666.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 08:07:10 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 08:07:10 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>
Subject: Help needed for a BPF kernel issue with S390
Thread-Topic: Help needed for a BPF kernel issue with S390
Thread-Index: AQHaZvh3F0M+T24l+Eeg2sZ4K7Ri3g==
Date: Sat, 24 Feb 2024 08:07:09 +0000
Message-ID: <c2d90fe3-9d8a-4f64-8136-126cf556d08f@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1666:EE_
x-ms-office365-filtering-correlation-id: 8ac11299-0d25-4d4f-e33a-08dc350f99c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p7lSJiTwDFkx/626DXJWOZTdzXkepcAUohxBqFvCRRKIL6/TjHAkah+ute212QUDb30Lt0SgJQwL0t0krQVGejf4iKbERhbvO4zMnsxVSsBqLYmYcOcPMS126Kf9T7aULL1U2INDFEjo6DQClJba3GnsBEbxtnlFRdWg/mkTMjEQR2VIWcBNhSz2IncaQZGIIUXyhAmQFQFFGUo2F/b7INMRSWH6R70rfNFmPGJujbegBIROWY2xSaCgsmQC3HPRJ3ZdNOzOlKGW+1sAmzYBf7iifhwuSjlryfyQilf/w2G/knVx+E/wprnd/nd6uBTXaSuVvedFP+HfnidG6RbV/zUDBJSOeMxB3dOED86T4tfeiGxNGOIhev6mXjCOFLHoytIpefW0adiikAnPNxq8vPpEjnbnzy2nAM7e6Bl/gX83yt5fg4QZ0IKZ9+7bmV9fmxOI5AGYx6nPmhTCqsj3QXvC/OkmZvMucPydaRmjYyZ7QPg8yjwaeBipdfpp1IMJrIl3JXfHYIGpG5V1i0ssDS7OsQ/zKZqSCse6YHuA09XQpv/YvOxZ/rY7TxTGYt++TD2Uj3iK3LwgUjYNMk3c8tiLUVXsKtW38QRxd2n1kRw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHptTUpyQnNNczlOOS9EczlzN24xZmF1UnF4REJZVlpKNk1vUGM0Z0dYR2wx?=
 =?utf-8?B?SktQcTIraUVnRDFPb0xBS040aVIvUkw3UU44QjM1MXZsU09mSFVaNzQrZjRp?=
 =?utf-8?B?RzZNTlQ2OFU4Z1piMWxYa3UzM2JCRWZCM2I2MkF4ZkxKN2c0cU1XNi92VzYv?=
 =?utf-8?B?TGdCK0tSNUlBRHVJY24xemMyZUgyQ1B5eWRaVXd1R1hFQk00V2dNQmZJYzNF?=
 =?utf-8?B?RVlkamJSUXhteHpWR3F3NXRBUmdnOGRuTktteWVIMllycTF6bnA2OTZ6UEhH?=
 =?utf-8?B?VDRsVEJXbS9ZQnJkUkZXYXZZdURVNjl5Mnd6RURETnZ3TFhodmlSbXpxME4y?=
 =?utf-8?B?bHpjRktIaHFzNmptUmFQdHNwNHY3YSsyR3RBSW1NK1BSMXFtZTkyT1BuUFRZ?=
 =?utf-8?B?dVFTZ210MDJTVzI2eXhCUkUyTEJGUDBtbDM1VVZYWFZhQlY4TDR6REpsZHVq?=
 =?utf-8?B?bjBrS3VReEF1V0lwVHBZbTNtb3hOeEk5MUxPcC9LeHNTOHJQYmpzNDFLUWlP?=
 =?utf-8?B?YjA3eTRTNWI1YjFpdURFWS9GcHJtTjJGUVRXdTBDTzFnSmZYYnY2MnNzQ1M3?=
 =?utf-8?B?UUZaSlVzaDg5WjZWbHlNRVJGV2J0ZnN1SHNZWWh3OHNKeFJHc1hCNnd3Sm1y?=
 =?utf-8?B?M3NXdkw5YWYwaEs5UU9uaFJqckpXQ1IrZTJ3NlhIeVJNMHltTE12SmU2TGEw?=
 =?utf-8?B?QndnMklxSlQ4eXA1TTFYV3VCd3ZadVlUc1NQY2c0QWFXWER6NUpKeWEvNVIw?=
 =?utf-8?B?NEZzaWIwakpZQml5OXZnb1U0ZnFhSERSS2ZjQmpLQ1BnZUFvR0NsSDJwZ0NW?=
 =?utf-8?B?YnZJVWZNUGo1U1NybW5xWGI4Qm5zdENVRElKV1MwMzNibHNRczlhcmQydzJM?=
 =?utf-8?B?SFVwYTlVcjFENjVVRG5Nb1BxOVdsYWVOUUM4cDBqaTdObXYrODJMelU0TUUv?=
 =?utf-8?B?VVdCdE9wT3ZZS0lFakErU3JDRnJMcGQrZmRDVDMyV3ZZK3pzdmRSd2JYTEVR?=
 =?utf-8?B?M2FCK0g5UXQ1b2FoUDFGMWdJckRtNmJkTXhvSHhaNDFHVmIyUXpLbXNTVHNm?=
 =?utf-8?B?NHhUcCt1dVpyTTdHU2gyaXF1Y3dxcGZ2WWNVQTgwR1JYWnVUbklmWURDRzcy?=
 =?utf-8?B?eVhTWDRyTUgwT2tyR0lmMFNPd2hiTWltN1ljUnVyUGwwc0ttMk1sUk1rTUtO?=
 =?utf-8?B?MmJjbzByaHo2RlZJdVk1MWJpOWl2YVFqM1BOVTlyNUsxQ2xsSWtVTEN1M1NQ?=
 =?utf-8?B?L3Y5eGpNQUQ1V2toMnd5Ti91VVo5cVp1dHBxaDY3L1NnTW9GWUI5cmIxMDds?=
 =?utf-8?B?dEZHdVhOODg3NFpabmVSZHpIVGxzd0wvSmU1d3ZnNjhRN2Q3aEdlbVI1dkZq?=
 =?utf-8?B?b2FyYWpSMGdqVG9vR1p5c0s0U1RBaVBSK0ZrVlp1eHpGSExrcVZXcG1yL2NW?=
 =?utf-8?B?ejgwcm9JQzVJSmVwNEZ0YnQ4Vnl2ZzlFbmVVVlBPUFEzaFpXWi8wVlNKYjZU?=
 =?utf-8?B?ZW9zVjFtbWozMmpVZnkvVFd4UER6SHFMbFluNzJzOGNCSUNVRTRjaGlNUVY2?=
 =?utf-8?B?NkJjY0tFUEhqUHQzSTVjUzAydXltaXhlaE1OdnR1UVRmVkVBemlYK0R3VlJI?=
 =?utf-8?B?Z3NHWnJUeHVlcW9hMjRjRDl0dkJlY2J2UGY3cFYvL2xYNlNsMFV0cTdzS2JI?=
 =?utf-8?B?djg5cGxMMzlsd3JzV0NmUkZRMnBXK3I5eWRvSFJFb05YMmgrWkkyLzh3akl3?=
 =?utf-8?B?dTVwbUw4UjZrVTFydDdTdWJwN3hDdjVVR3NRVHEvYStDZ1NtRnpCWUh5dlZa?=
 =?utf-8?B?RkNBc0poUGNseDRRdmRJRmxYTzNJTjkySjhqbTAyeGFzM0lNK2dTbWpVbHlJ?=
 =?utf-8?B?dHBMeXBtK29BeVdhcURKSUgrR0hPakxNd0ZuVGc2TWFpRjRmNC9mUHRvV0FV?=
 =?utf-8?B?Wmx0djBhK3VMZnFSUElwUGIyTk5QZjR4OU5GWGMzcjhPc2NwT082WTY5TUor?=
 =?utf-8?B?VEVmdEhGUXRkaTlaREpZU3lTd0NRcmFOcUNVWFdvRTNHUGhQbWtSK25IUk5o?=
 =?utf-8?B?RXBNbnRjRE5nS1VzaTcxekdhWXh2NGQySTI3bnZiR1N5VnNhUmhnMkJla1dV?=
 =?utf-8?B?Z3FBTWpHd1QzbkxRTUlpekpDUFVoaVhvbk16REdtZ0x4WUZpbEF6OUlNVGJQ?=
 =?utf-8?B?WXlKL0dyRHNmbjkrM2d5N2hpMHRJbFFJRVdhWUhqZHdNMUJJUzQyVUVhemJh?=
 =?utf-8?B?UEFiNlp6Y3kycWcwekRFUUdxNkRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A08753DEC9B1F48AB3DDCC084C72F5C@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac11299-0d25-4d4f-e33a-08dc350f99c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 08:07:10.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoO6v0Z8boPgRRKZZCeN76rsBMORkCjpA+763KCkON0zTpjTmSNP6smbA7qGh/ctWfLLGMOiqYRYdBBbMbNh3NyRUXvww/H6vjmNFXnMsiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1666

SGVsbG8sDQoNCkknbSBzZWVraW5nIHlvdXIgaGVscCB3aXRoIGFuIGlzc3VlIHJlcG9ydGVkIGJ5
IEJQRiBDSSB0ZXN0cyBvbiBhIGNvcmUgDQpCUEYgcGF0Y2ggSSBwcm92aWRlZCB0byBpbXByb3Zl
IHNlY3VyaXR5IGluIGxpbmsgd2l0aCANCmh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lz
c3Vlcy83DQoNCkkgc3VibWl0dGVkIHBhdGNoIA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8xMzVmZWVhZmU2ZmU4ZDQxMmU5MDg2NTYyMmU5NjAx
NDAzYzQyYmU1LjE3MDgyNTM0NDUuZ2l0LmNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldS8NCg0K
QXMgeW91IGNhbiBzZWUgaW4gdGhlIGNoZWNrcyBsaXN0LCBJIGdldCAiYnBmL3ZtdGVzdC1icGYt
bmV4dC1WTV9UZXN0LTE0IA0KCWZhaWwgCUxvZ3MgZm9yIHMzOTB4LWdjYyAvIHRlc3QgKHRlc3Rf
cHJvZ3MsIGZhbHNlLCAzNjApIC8gdGVzdF9wcm9ncyANCm9uIHMzOTB4IHdpdGggZ2NjICINCg0K
VGhlIG91dHB1dCBpcyB0aGUgb25lIGJlbG93Lg0KDQpDb3VsZCB5b3UgaGVscCBtZSB1bmRlcnN0
YW5kIGFuZCBmaXggdGhlIGlzc3VlIG9uIFMzOTAgPw0KDQpUaGFua3MNCkNocmlzdG9waGUNCg0K
T3V0cHV0Og0KDQouLi4NCiAgICMyNjIgICAgIHJlZ19ib3VuZHNfcmFuZF9yYW5nZXNfdTY0X3U2
NDpPSw0KICAgIzI2MyAgICAgcmVzb2x2ZV9idGZpZHM6T0sNCiAgIENhdWdodCBzaWduYWwgIzEx
IQ0KICAgU3RhY2sgdHJhY2U6DQogICAuL3Rlc3RfcHJvZ3MoY3Jhc2hfaGFuZGxlcisweDQwKVsw
eDJhYTA5MGM1Y2E4XQ0KICAgbGludXgtdmRzbzY0LnNvLjEoX19rZXJuZWxfc2lncmV0dXJuKzB4
MClbMHgzZmZjNzhjZTQ4OF0NCiAgIC4vdGVzdF9wcm9ncyhyaW5nX2J1ZmZlcl9fcG9sbCsweGM2
KVsweDJhYTA5MTJiYmU2XQ0KICAgLi90ZXN0X3Byb2dzKCsweDI4MzQ5MClbMHgyYWEwOGY4MzQ5
MF0NCiAgIC9saWIvczM5MHgtbGludXgtZ251L2xpYnB0aHJlYWQuc28uMCgrMHg3ZTY2KVsweDNm
ZmI4YzA3ZTY2XQ0KICAgL2xpYi9zMzkweC1saW51eC1nbnUvbGliYy5zby42KCsweGZjZDQ2KVsw
eDNmZmI4YWZjZDQ2XQ0KICAgWzB4MF0NCg0KICAgdGVzdF9wcm9nc1sxMTZdIGlzIGluc3RhbGxp
bmcgYSBwcm9ncmFtIHdpdGggYnBmX3Byb2JlX3dyaXRlX3VzZXIgDQpoZWxwZXIgdGhhdCBtYXkg
Y29ycnVwdCB1c2VyIG1lbW9yeSENCg0KICAgVXNlciBwcm9jZXNzIGZhdWx0OiBpbnRlcnJ1cHRp
b24gY29kZSAwMDNiIGlsYzoyIGluIA0KdGVzdF9wcm9nc1syYWEwOGQwMDAwMCtiMWYwMDBdDQoN
CiAgIEZhaWxpbmcgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMCBURUlEOiAwMDAwMDAwMDAwMDAw
ODAwDQoNCiAgIEZhdWx0IGluIHByaW1hcnkgc3BhY2UgbW9kZSB3aGlsZSB1c2luZyB1c2VyIEFT
Q0UuDQoNCiAgIEFTOjAwMDAwMDAwODFiMzgxY2YgUjE6MDAwMDAwMDA4MWIyYzAwZiBSMjowMDAw
MDAwMDgxYmY0MDBiIA0KUjM6MDAwMDAwMDAwMDAwMDAyNA0KDQogICBDUFU6IDAgUElEOiA4MDQg
Q29tbTogbmV3X25hbWUgVGFpbnRlZDogRyAgICAgICAgICAgT0UgDQo2LjguMC1yYzEtZzY5MGI5
MTJkOGJiNy1kaXJ0eSAjMjE1DQoNCiAgIEhhcmR3YXJlIG5hbWU6IElCTSA4NTYxIExUMSA0MDAg
KEtWTS9MaW51eCkNCg0KICAgVXNlciBQU1cgOiAwNzA1MDAwMTgwMDAwMDAwIDAwMDAwMmFhMDkx
MmJiZTYNCg0KICAgICAgICAgICAgICBSOjAgVDoxIElPOjEgRVg6MSBLZXk6MCBNOjEgVzowIFA6
MSBBUzowIENDOjAgUE06MCBSSTowIEVBOjMNCg0KICAgVXNlciBHUFJTOiAwMDAwMDAwMDAwMDAw
MDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCANCjAwMDAwMmFhMGRiY2Y1YzAN
Cg0KICAgICAgICAgICAgICBmZmZmZmZmZjAwMDAwMDAwIDAwMDAwMDAwMDAwMDI3MTAgMDAwMDAz
ZmZiNmQwMDkwMCANCjAwMDAwM2ZmYzc4NzdhZDcNCg0KICAgICAgICAgICAgICAwMDAwMDNmZmI2
ZDAwMWUwIDAwMDAwM2ZmYzc4NzdhZDYgMDAwMDAzZmZjNzg3N2FkOCANCjAwMDAwM2ZmYjZjZmZl
NTANCg0KICAgICAgICAgICAgICAwMDAwMDNmZmI4ZTI2Zjg4IDAwMDAwM2ZmYjZkMDA5MDAgMDAw
MDAyYWEwOTEyYmI4OCANCjAwMDAwM2ZmYjZjZmZlNTANCg0KICAgVXNlciBDb2RlOiAwMDAwMDJh
YTA5MTJiYmQ2OiBlMzEwYjBiNDAwMTQJbGdmCSVyMSwxODAoJXIxMSkNCiAgICAgICAgICAgICAg
MDAwMDAyYWEwOTEyYmJkYzogZWIxMTAwMDQwMDBkCXNsbGcJJXIxLCVyMSw0DQogICAgICAgICAg
ICAgIzAwMDAwMmFhMDkxMmJiZTI6IGI5MDgwMDEyCQlhZ3IJJXIxLCVyMg0KICAgICAgICAgICAg
ID4wMDAwMDJhYTA5MTJiYmU2OiA1ODEwMTAwOAkJbAklcjEsOCglcjEpDQogICAgICAgICAgICAg
IDAwMDAwMmFhMDkxMmJiZWE6IDUwMTBiMGJjCQlzdAklcjEsMTg4KCVyMTEpDQogICAgICAgICAg
ICAgIDAwMDAwMmFhMDkxMmJiZWU6IGUzMTBiMGE4MDAwNAlsZwklcjEsMTY4KCVyMTEpDQogICAg
ICAgICAgICAgIDAwMDAwMmFhMDkxMmJiZjQ6IGUzMjAxMDA4MDAwNAlsZwklcjIsOCglcjEpDQog
ICAgICAgICAgICAgIDAwMDAwMmFhMDkxMmJiZmE6IGUzMTBiMGJjMDAxNglsbGdmCSVyMSwxODgo
JXIxMSkNCg0KICAgTGFzdCBCcmVha2luZy1FdmVudC1BZGRyZXNzOg0KDQogICAgWzwwMDAwMDAw
MDAwMDAwMDAxPl0gdGVzdF9wcm9nc1syYWEwOGQwMDAwMCtiMWYwMDBdDQogICAuL2NpL3ZtdGVz
dC92bXRlc3Rfc2VsZnRlc3RzLnNoOiBsaW5lIDY5OiAgIDExNiBTZWdtZW50YXRpb24gZmF1bHQg
DQogICAuLyR7c2VsZnRlc3R9ICR7YXJnc30gJHtERU5ZTElTVDorLWQiJERFTllMSVNUIn0gDQok
e0FMTE9XTElTVDorLWEiJEFMTE9XTElTVCJ9IC0tanNvbi1zdW1tYXJ5ICIke2pzb25fZmlsZX0i
DQpiYXNoOiBsaW5lIDU6IGNkOiAvdG1wL3dvcmsvYnBmL2JwZjogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQ0K

