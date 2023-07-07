Return-Path: <bpf+bounces-4383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0874A8AA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 03:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AC2815F5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924D15B6;
	Fri,  7 Jul 2023 01:54:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1D7F;
	Fri,  7 Jul 2023 01:54:08 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197119B7;
	Thu,  6 Jul 2023 18:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gasbIQPG+RiGBS7iEWuObPFquqg+yJCUqEYMQ9N+7U+IxjCsc+PqmsWmAxfSLxIdObmMqrLKrplFdsxiqOuh6rR4i9c6DtSRiAYJkcPSP68W2IHjMX2+VGpbrSU8pKYwE+V3Zud19p01dXx+61FQb5EfRith/KhiVD500P7j4OnpGQpuMrLZYcw7N5dsDgwkGH8Pej7np6wmxMReKORRohWlLjPTXH6L9TIbOQO7S0yg69DMTqJOClIrCzkeNwHfup//qxNqImQwPIi9W9oJSv6ag+5es+tb46WZx74DqgXDORDZvN3X8YJbfghqGPvk6Cec4wmnsqVk9yCK/ylg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ5LJqtojOgCHogag/tLxezGtlI6JAJEKvyLPinEAWg=;
 b=E68+7RkdjxtISrRbz8pHATsS1UvEW9KkOX6ytmv4muKVE2vxz4g8ieW4NnIEk/H82K4COAw4MmdKk6OTyQ8bN8zjgnaj52FioyLiH7qRFMARumfCkHzysaI55fYUcaCO2ZVAXyYJ/18zE0g23qTeEMLusPG+eAkPE9I2aBUIjJZct/7JlXOby+sahotcfRgaWp5h0cOiLjx0PgCA3e/UF00Pli6iRaFKmqA/SCpBdvsqSBu49/PULoDnHMcyEXaW2yR5fKX5pvw/GgPqvKLTVLmKvEwu+nL/59fv5Rl/P9rI7N1l3yq+gZrOeYBf4ChrcKckqcGmCrBKO7B7Fbwxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ5LJqtojOgCHogag/tLxezGtlI6JAJEKvyLPinEAWg=;
 b=chXJt/oUIaE1rxi6Ip0PLXx/xVZBtII4RExb0Dyt4twTLljt0RVcFyj2FygE1cESWWY5ANirGSSHmwQZdNt8JksPxdeBXcU/8OaxkKWp/J1Ptaj5zkAImStpvYBYaL1ve57pxAiOu7+ouQSmPO22q5BcTr4R2X6G/rDob7knTCc=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 01:54:04 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 01:54:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH V2 net 2/4] net: fec: recycle pages for transmitted XDP
 frames
Thread-Topic: [PATCH V2 net 2/4] net: fec: recycle pages for transmitted XDP
 frames
Thread-Index: AQHZr+I5Ou1g51VkvkaNhIykwJ3t4K+sotEAgADhnlA=
Date: Fri, 7 Jul 2023 01:54:04 +0000
Message-ID:
 <AM5PR04MB3139BAF71F71A7681E3D0D57882DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230706081012.2278063-1-wei.fang@nxp.com>
 <20230706081012.2278063-3-wei.fang@nxp.com>
 <7df8d76c-e177-b06c-20e4-e6aacbea6471@intel.com>
In-Reply-To: <7df8d76c-e177-b06c-20e4-e6aacbea6471@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DB8PR04MB7019:EE_
x-ms-office365-filtering-correlation-id: 1ab4b762-4074-4bfd-8274-08db7e8d0b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ho63eI+qtTaLfUnvPEqtXgmvKBG9aluoNVt+3HSb9rQ71YV0iFPGwUdDRWHxe+Hx7tnBmBQyX3CuNJV6ErrRPvWc6bF+VQyziPyiIeNHlTvAcGCUu/kuLoZJqR5FaDgeIAR+0Xlad0oF8aVl5BXNomDYOLhVj4/Gtui7PFCP2ByolvaCUCFVZVzj9TnH3xBPrINxy5JNHKq85fUdQjofVakLYDDc7M67NaAMjiK9BbroRMtrpZkdbNR8tVQnzA9LMJ08e79E7sgXyi72tLpe+H/Iq5S20AShDQpBITLEQeeP/l0jFhlezfZ32FkQXckijzI4f72QTMVhvok3ETN/AP5ple/ub5bXu52rpqyf0/wC86lDmoRAa3D1YerTuTNRpHYUE9W1TtoTKNiTMKHpDlnU57I7tUx2MQOikODwZHJBvIfS9GP5fLnZ6y/Rem+6uCJHVe48PS40Mx+08MpFJDD7fVCHMgtev3KY24dv3ZBmUZTMNbqprVv5opuAR15yEjN7yE/gKNhrPzgtL2JAV5WnJ9VXcz7d7oziRQCojBJutWU02nbmM/QndJmWNHA3WQTNgWG41yR4HFJ9hcnq2ddJegIm6VFDHF/Y+AD+mnvgIhTDMsbchg8aweCTYloT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(55016003)(71200400001)(66476007)(54906003)(7696005)(122000001)(478600001)(6916009)(76116006)(8676002)(41300700001)(8936002)(66946007)(64756008)(66556008)(38100700002)(4326008)(316002)(66446008)(186003)(83380400001)(6506007)(53546011)(26005)(9686003)(5660300002)(2906002)(44832011)(33656002)(86362001)(38070700005)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjRhdmkwMjZ4c2ErRGl2ZEVQakhlcVlTQ3pZUC9jdjNPOEJNUEN0RkdHdGFl?=
 =?utf-8?B?bjZlaWlQRTFLbThqaDA1OVBaVFE5SHVuM29HQjZYaG9NSDNGNWJFcUNqNldF?=
 =?utf-8?B?SFVOeFpORGQ1OTdrK2d1Q1M2VURnOXZNenhqYThjanZjbVh2NE54UGtxdGN6?=
 =?utf-8?B?VVlYSUwwaU5kNFh3alVpTk1jNTZBak1xc25pd2YxUC8yMHl3bmpQUksvMGhm?=
 =?utf-8?B?YW85N2hTSVo0Z0RxTk9wM3psdlpFNVBvK1RvVGJCNjlIYjNMVTVHUTBxZjBG?=
 =?utf-8?B?cjFBdUdncy85b2FwTHFYclZGbjViMjF3L2dpZlVmYlNDZFBrVzlLTHJxcktW?=
 =?utf-8?B?T3dWd3ZXNkJtTUludXRZTDl0M1gwclkyUWtTbEg0SThLemVLcGlJblREVVZY?=
 =?utf-8?B?S1FQaDlvay9oT1hkUnVtakhJN3ptdEVPc0ttV25JQ3o1ZEwvd043KzlyY2NZ?=
 =?utf-8?B?VnhJSEI0ZHg1MWQwUU9GM2lsTmtjWmdsUEFqbkI2ekptbUkrMFRKVzlaRXhH?=
 =?utf-8?B?UW1nQm4ycHNGYzVwRldWNlRZMWZ0dmtzcERBcEdPTWlyV2ZpYW5wVE9xeUl3?=
 =?utf-8?B?bTBGZVRVdHVHVUlHMUlQV0NDQ05yRkl5ZkRhV1F0Ty84OVNzUVl1QUE4OEMr?=
 =?utf-8?B?NFV0RXJ0VWExNVB1S3JpVXRqRTBGN1d5L0FwcDFBSDVrU09JdEZJa2l5OS9o?=
 =?utf-8?B?Uit6UGJ0ZEVWQ2oxdkVMVXc3Uys0K1NITVJ6eGtXR2xTRXZ4MS9Gakx5a0lU?=
 =?utf-8?B?Njcvd3dqKzV6VmNKZko4MmE1MlFiaS9DT0NnNGQydC9EVlkrOHp1WXVBaElY?=
 =?utf-8?B?d2pSNnAvdm85OEZETkFCQm15STVZbk12c09PdG9KdUJHdGFtdXMvTGdpQTBj?=
 =?utf-8?B?bHJwUHNHT0lNcWJDb2xyc2oybVd3UHNpYS85MEpFVUxwNnNacnlJeW12NzFP?=
 =?utf-8?B?dE5oRG44K2RTM1NkbEdlcUNSMEl6UkxTNVJ4dUxDQ1NkVEY2MzV4ZEtNTm1V?=
 =?utf-8?B?SEVPOWVZMFRISUhjM3M5UnBCUG0xRU9NeGlTSGtaMzBjck9XdDlWdkpKd2dy?=
 =?utf-8?B?UUpWQ2QvNFg5S0krblVzZkdIT3dpd2hGNTNxSFJBZDQ2NzJYMjVpY2EwR1h1?=
 =?utf-8?B?UUxHcHk4R1Zjbi82eFROMHN4dCt3TFBTQUk0K1RGU2FGVWxWNDBDRkdjaVR1?=
 =?utf-8?B?endNOXJYcVVwQVRwVmNrS0VoWnBaa0VwRkpqS1ZQYi9tWWxWQnUzZXV4ZkFx?=
 =?utf-8?B?TGZKeUxabC9aMDRDVEM4U01qcGdFSkVvMDZBTk0yT2V3Rm83eS8wN1IvdmVL?=
 =?utf-8?B?aHM3dzFzNFZNS2RHVkdYV0E3bmRsbW1WMzZYUEVMcVNtRWxjSXlVeEhmV2xw?=
 =?utf-8?B?c3czbkNQd0dQdWpsZVEyYmdRcmZWMFpmREd1andsc3I3b0tKREhqUm91MWRB?=
 =?utf-8?B?ODh1WEVtNldGaHQ5TE9VRXY2NGhRckxtOGV6Ym0xZ0tyMW5icitONThNMHJU?=
 =?utf-8?B?VHFZY3Nlb1ZUSTZqZFJUcHNiWkQvRURZdlJCbXJockFxRFlZUUp5SHBhRVF2?=
 =?utf-8?B?QmgvVG1jT3AzQWdKeHRzMGpJOHdjbXcrejBIa0c2OEFDUkttaENtajAxYjVP?=
 =?utf-8?B?dmlIZDhvWTdoWDlFMjI0VDdPcGdGM3BrU0FnQlczTjhwbmZHQUo1R2tidk5N?=
 =?utf-8?B?WWFrcW12M3B4T2xsVkdXNjVKYmlySnZBL0pWT3RLaE93N0VxYys5dUp4c3hx?=
 =?utf-8?B?TVdrUGpHMjZ4LzRiQU44VlU0WEMrOTRWMXRDQ1dYVW0wamo0Uy9ZTFpZQkVO?=
 =?utf-8?B?M2E4Tm1ZemFDMVV4QXE4K0FieVpoQ013RUtNSmdLak9zQW1LYnV4YTNJK3V5?=
 =?utf-8?B?dDA4Zk5WSXpBdHBUTnVxSE5ZZEk3Njlnemg0TTVTR25jQjdMV2c3SU5Xd1Qy?=
 =?utf-8?B?SkZHV2dSQWxDeFY2eitDQXk1Y2czUUo5OUsxZllpejdYdGFwdzV0UkpjZDk4?=
 =?utf-8?B?aUc2WUFRd0hTM0pDRmpWYWtPbWRNN09oTkZ5dnBPUHNQcFZFTHVYVzVlRmNi?=
 =?utf-8?B?ei9STSszWks1U3ZPNXl3eEtJWHFrS2E4d1VZWDd2NEtEYmxRRTNiT1krM2Mr?=
 =?utf-8?Q?i2HE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab4b762-4074-4bfd-8274-08db7e8d0b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 01:54:04.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3o+2ZMuE5Mw2ogjKjgkaYwGwIJipR/4zsCfdrqH0fj4PMZF7WnvtDcIMLe7Q2gwtaHR1fJ+fKj+U93mhiasxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDfmnIg25pelIDE5
OjU5DQo+IFRvOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5p
QHJlZGhhdC5jb207IGFzdEBrZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsNCj4gaGF3
a0BrZXJuZWwub3JnOyBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207IFNoZW53ZWkgV2FuZw0KPiA8
c2hlbndlaS53YW5nQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIG5ldCAyLzRdIG5ldDogZmVjOiByZWN5Y2xlIHBh
Z2VzIGZvciB0cmFuc21pdHRlZCBYRFANCj4gZnJhbWVzDQo+IA0KPiBGcm9tOiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gRGF0ZTogVGh1LCAgNiBKdWwgMjAyMyAxNjoxMDoxMCArMDgw
MA0KPiANCj4gPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IE9u
Y2UgdGhlIFhEUCBmcmFtZXMgaGF2ZSBiZWVuIHN1Y2Nlc3NmdWxseSB0cmFuc21pdHRlZCB0aHJv
dWdoIHRoZQ0KPiA+IG5kb194ZHBfeG1pdCgpIGludGVyZmFjZSwgaXQncyB0aGUgZHJpdmVyIHJl
c3BvbnNpYmlsaXR5IHRvIGZyZWUgdGhlDQo+ID4gZnJhbWVzIHNvIHRoYXQgdGhlIHBhZ2VfcG9v
bCBjYW4gcmVjeWNsZSB0aGUgcGFnZXMgYW5kIHJldXNlIHRoZW0uDQo+ID4gSG93ZXZlciwgdGhp
cyBhY3Rpb24gaXMgbm90IGltcGxlbWVudGVkIGluIHRoZSBmZWMgZHJpdmVyLg0KPiA+IFRoaXMg
bGVhZHMgdG8gYSB1c2VyLXZpc2libGUgcHJvYmxlbSB0aGF0IHRoZSBjb25zb2xlIHdpbGwgcHJp
bnQgdGhlDQo+ID4gZm9sbG93aW5nIHdhcm5pbmcgbG9nLg0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
KwkJCQlpZiAodHhxLT50eF9idWZbaV0ueGRwKSB7DQo+ID4gKwkJCQkJeGRwX3JldHVybl9mcmFt
ZSh0eHEtPnR4X2J1ZltpXS54ZHApOw0KPiA+ICsJCQkJCXR4cS0+dHhfYnVmW2ldLnhkcCA9IE5V
TEw7DQo+ID4gKwkJCQl9DQo+ID4gKw0KPiA+ICsJCQkJLyogcmVzdG9yZSBkZWZhdWx0IHR4IGJ1
ZmZlciB0eXBlOiBGRUNfVFhCVUZfVF9TS0IgKi8NCj4gPiArCQkJCXR4cS0+dHhfYnVmW2ldLnR5
cGUgPSBGRUNfVFhCVUZfVF9TS0I7DQo+IA0KPiBIZXJlIGFuZCBpbiB0aGUgcmVsYXRlZCBwbGFj
ZXMgYmVsb3c6IG1heWJlIHNldCA6OnR5cGUgZHluYW1pY2FsbHkgd2hlbg0KPiBzZW5kaW5nIHRv
IGVpdGhlciBTS0Igb3IgWERQIGluc3RlYWQgb2Ygc2V0dGluZyBpdCBvbmx5IGZvciBYRFAgYW5k
IHRoZW4NCj4gcmVzdG9yaW5nIGVhY2ggdGltZT8NCkkgYWxzbyBjb25zaWRlcmVkIHRoaXMgbWV0
aG9kLiBidXQgd2hlbiB0aGUgc2tiIGhhcyBmcmFncyBvciBuZWVkcyB0byBiZSBUU08sDQpvbmx5
IHRoZSBsYXN0IHR4X2J1ZiBvZiB0aGUgc2tiIG5lZWRzIHRvIHN0b3JlIHRoZSBza2IgcG9pbnRl
ciwgYnV0IGFsbCB0aGUgdHhfYnVmDQpvZiB0aGUgc2tiIG5lZWRzIHRvIHNldCB0aGUgdHlwZSBl
eHBsaWNpdGx5LCBJIHRoaW5rIGl0IGlzIGEgYml0IG1lc3MgYW5kIG5vdCBjb25jaXNlLg0KU28g
SSByZXN0b3JlIHRoZSB0eXBlIHRvIGRlZmF1bHQgd2hlbiByZWN5Y2xlIHRoZSBCRHMuIEFueXdh
eSwgaXQ7cyBqdXN0IGEgZGlmZmVyZW5jZQ0KaW4gaW1wbGVtZW50LCBpZiB5b3UgZ3V5cyBpbnNp
c3QgaXQncyBiZXR0ZXIgdG8gc2V0IHRoZSB0eXBlIGV4cGxpY2l0bHksIEkgd2lsbCBtb2RpZnkN
CnRoZSBwYXRjaC4gVGhhbmtzIQ0KPiANCj4gPiAgCQkJfQ0KPiA+ICsNCj4gPiAgCQkJYmRwLT5j
YmRfYnVmYWRkciA9IGNwdV90b19mZWMzMigwKTsNCj4gPiAgCQkJYmRwID0gZmVjX2VuZXRfZ2V0
X25leHRkZXNjKGJkcCwgJnR4cS0+YmQpOw0KPiA+ICAJCX0NCj4gWy4uLl0NCj4gDQo+IFRoYW5r
cywNCj4gT2xlaw0K

