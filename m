Return-Path: <bpf+bounces-7143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A21771C80
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCF1C20A11
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BEC2EE;
	Mon,  7 Aug 2023 08:42:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547853D79;
	Mon,  7 Aug 2023 08:42:12 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC319199D;
	Mon,  7 Aug 2023 01:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8cXXsmA8C2vmmFHqd0qSQkDglbueUPAYfZbdMJRdt5LmvGTLgplM2XECA4z9U+obqxE8+gv4XzsCWsesJN+92OYCg/1WjiHzqOZasAhDX0ohehS1N23gTsoHlol+Nbg75W7HXbn3zvRSXmPBhtGJDBgq1VRfH57C1Q0p9dLhPNEjYpqAOfC+srpKTMXXsi3lUOn/e5r+AfRkQBXu4PXhnuRHDLlIJsECjcrcF5rKhjuRA/VaeWJxL+U5LZqkNj7aZI772jPvv81eM3ok7x9Sag68kMjkKqaqR+Aj1IeIHK+6KyRP6QZ6ES+v6MghBL5VeFG6BQJbpfAyVo5PLsu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBavg4W9IGyPTef+MPq97QK8LZlmIC8cI9T65s617Ac=;
 b=Zg04PFLoEUpgvx6OhLqm5kGEyqV2vuC4ebagS1d+X9Rs3LmuHLQdmbyOu1WGRFWzlDGoRSkt8BI2FbJFEJz3PyNjZ3Kc8wMJ2gq7H3VMBNSKYc5WQFMy8p8tMpvAzhsE7lXD3EVd/W9CG/y9kTePlLAnHuAeNw7L/aR+rcpi/8DTcHfzcWzQHDaFfkeZxycEQ71z2T2haKEwYviN3Jz9B9spoXD7iPmpfuqIs6HLgL7mD1Quq9yz5QAR2dAsuZkxaYglKFc9yyn0//a9BBCxM9fxVLipRkplocqazBy0zDEq9dHILWJLj7XCmSAWAbKqT30FKBbCjeIolIpvsF1TfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBavg4W9IGyPTef+MPq97QK8LZlmIC8cI9T65s617Ac=;
 b=mt720QewmtPa322lWpW7iIEKXQMavgyflXqXyQLYn6gUChdww1EQRqcIPNgiH/IzegTOi/sFQnv/NjLy/uw+CaZB+pQU4pwJt6dFXzrINddsR3AMR6Dl5W2TuzecFXjsMjUej50yaadOETcne8bf+VVkPhrsZzTO7F9KzhJWmy8=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DBAPR04MB7349.eurprd04.prod.outlook.com (2603:10a6:10:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 08:41:58 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 08:41:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>
CC: "brouer@redhat.com" <brouer@redhat.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZw3VFF5NSBizeREOxLxVc18wksa/WwA6AgAAZpQCAAziEgIAEen9Q
Date: Mon, 7 Aug 2023 08:41:58 +0000
Message-ID:
 <AM5PR04MB3139DC4A790A8A45FC93486E880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <3d0a8536-6a22-22e5-41c0-98c13dd7b802@redhat.com>
 <AM5PR04MB3139E5A9A0B407922A33BF99880BA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <3a11f1e2-ee5d-676f-2666-0cee8bcbed6b@kernel.org>
In-Reply-To: <3a11f1e2-ee5d-676f-2666-0cee8bcbed6b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DBAPR04MB7349:EE_
x-ms-office365-filtering-correlation-id: 41835c34-91dc-467b-898c-08db97222953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gag2af7YUiZATvtxN4FHOaVehBEI4gWusmCHTANrWu5tMLZ2lwnky9JTqrw+lhVq9KuSzQgkM80jylZ4JK/m5+zy83pq2cDdRczf8Vr3um3ofq3IbmOSmFPohIYnojCbWVyfgkxEXO5WoZvgHIuhdY2Abig1OuaFbMsJwH9tiLYlh2dZQBPMb8jmGUp2eVkcO/PBBJjFpDqw274hJe9Y5dCxsu21bnDi4JXoUoE8jA6lUVb2JNObaRA301Zje6GIQlhL3CSGnBc2qezN3rzE2XEcv1OuqNJqqRgbXV8PkaED2GICv1yfbHLbN0v3NCpYn4KA4l9yveb5dkFyx4U5TbRC8Glz5uqDVxhTFRRGbzAKAflfGVcbnIT6q/I66BaVXpxz5DoRVHYocgAuvDZW47l5SRrn6ltBKoF7tFt9wPG4uiGzLxGJ551L/h9j46LNv7wmfdSEofDZkN5Sj4DN7p2xdBmHyMAibmplqqgbO9tzIFlTJzWANimDVZuOP3aPLVMwJEa8JhjgBWhfejQV6pl3YmmD9enEj3u9Bu2T9mOlFj6t2P8qOY3mtfG9zLUqI2xpqLDm8C9Yomug9ZuPwcsol7i0kOsaUMNI951BDL87qTHjvGJYjN9uIGwjCMaS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(1800799003)(186006)(9686003)(26005)(55016003)(6506007)(110136005)(54906003)(38100700002)(44832011)(5660300002)(7416002)(38070700005)(52536014)(86362001)(4326008)(2906002)(66946007)(64756008)(66556008)(76116006)(66476007)(33656002)(41300700001)(66446008)(8936002)(8676002)(316002)(71200400001)(7696005)(122000001)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0JqNUhEMzAxV2FSMitSZjVVcm5tdmpNR3I5R05SMFZKRUZxcDJnckd5aHRp?=
 =?utf-8?B?YVdiSk5WL3FxQURNYXcvTWp6cGVyTGpLc1Z4bHBjZEVSSzFRT2cweXVNRm1n?=
 =?utf-8?B?bUFtNytVMEk5VjdDUlN1Z0lWQk53eW5zQS9Hbk02RUNBZE9lbG9WMjFOSnhk?=
 =?utf-8?B?dkRaM1Bjd2lOU2g4bTJRUHNxMmZtMzUwZC83MGNhUzBXdzN2YWF2OGdGMlMr?=
 =?utf-8?B?WjRPSUZ2cjcySzJKaFE4VmY1bjkzWWxqRlJGTjNFMEVkMDVPTG56eFNwVXNq?=
 =?utf-8?B?ZXM1Nk9QVjh6QW51Nlh6NitBdUJERzNrODlZQzhSTXE2ZDlZNUpEWWptbm1D?=
 =?utf-8?B?R2MveTdvZTlNV3krVk50SmFrcVc3SEoyNjlXUnBwYit5SlBrNVBxR1ZGRU8r?=
 =?utf-8?B?dDR5YUxGTU9DeWY5am1pUEwwOUR3YmFYcVNBQ0ZwalFqdjcwUUczVDZOcmJU?=
 =?utf-8?B?NXJJVmhPRUJ1V3JmK2tyUVZRZjhvbjBweE5iek1WT0ZLV3RiUmoyNFdYTzZU?=
 =?utf-8?B?Uk1KS0VNN1JQRkVJQURuNEs3SmpCeWpPZzhCSDhwM0FBaUdRUjBGOU5ucm5y?=
 =?utf-8?B?ZHFaL0l1UDlpcktCbDBhV2tScHQzUVc3QXI2YWFwMkFlWEF5Qlkwa0h2U3hH?=
 =?utf-8?B?VTFTUFlFUFBEb1pTWXpDUmdSYVM5eDZJUlVwSmVOeU5rREo3ZmdhNXBkU2dw?=
 =?utf-8?B?NWxEQzI3cG1YekZScjAzLzN0Y3R1WW5rWHExUDZTR0lLaTZOeDlSakpaY0Fx?=
 =?utf-8?B?QUMvQW1HaE1HZklJU2R3ajJQVmMzTzNsa09KMlROV0Y4MkJ5dHJGbzl1c3Nz?=
 =?utf-8?B?SnNJT1lVa0dJM1hhWXRldzQ1VW13MmRPeG5YNmIrcEJ2djBjZUpmK0NkVnJY?=
 =?utf-8?B?WE1FaisxYUVpMjJCY2U0WlVvQXVmaTdQcGxCQktBYW9DRjhydUhJcjhJaEZP?=
 =?utf-8?B?K01QRThYRW5sa2hZUTdveUh1cGxJaDZtRFlNRWRIYUF6NkJPeWpLUE9Kblpn?=
 =?utf-8?B?Y1l6V3Z0OUNBNk1iRjl2YW5nUnFUdmJETU1qMGJvNWtkaFlCb0oweGwxazRN?=
 =?utf-8?B?Q3dnYTM2L3BORXBSLzZWSFZ4eUpwV1o0UWFhZEtOV0F4ZGpobDA4a3VIdm9F?=
 =?utf-8?B?NDRqQVM5NnQ0WGhvdFlKaCtCQktlTHI0SkQvTHA3bmt2ZCt3ck40ckFXb1hX?=
 =?utf-8?B?UnUrcjBDWSs4NUNmVG9BZnZEU3VtMFNmd0NHdFNqZmErcEphL0JNclYwSitP?=
 =?utf-8?B?RUdKL2phSHJCLzBEOHJkYjZ1bmVZY1NrSVlXVnkrU0dYRXAra1E1c0RtSmNP?=
 =?utf-8?B?R1ZITTYrRmtXNDNObWZKMTJVWit1LzMvY3FKazBlcW9ZeXdxaHQ1YjBHNEFZ?=
 =?utf-8?B?Z3RCYUJYc0YzQjNkZzQxSENRZnlHZnQwSHNRUlhZbURqNDBpLzBzSmVxYWls?=
 =?utf-8?B?aDRuSXNCT1dQalVWalNac1Bub1kyaW04UVNQRGd6N2wxMkhDNUZvZncyMita?=
 =?utf-8?B?MlI4UDQ0eTZrSFdnSS9YSjUyTE5NKzBXVFBRWVgySjBXdWtVSFFOakZNKzNw?=
 =?utf-8?B?TGdCajREZnAyeFNJVDY1dUpRcjg3TXBkRDF2OEQ0VEpYNjQ3V3BudTMxanFJ?=
 =?utf-8?B?YnBGdGpWK3cwTDE4YTlqdW93RDFUNHhZVHBUanBJTU9FYWJMZi9xN1JVeEta?=
 =?utf-8?B?QUNGWVQrWmxuUDVyVzM5ODJwOWJheWhWeE1IKzdkUmFSWmY5L3BrNjFEeGZS?=
 =?utf-8?B?Y1NsSW96ekE2ZUl4T1k5VmlHNnBkUHJlZWZySjhGeU5zN0NSK2hzUkhQaVdN?=
 =?utf-8?B?TXozREZzazJCMit2TFIxR0czK0lweTB2Mkx0WlBGL2xXeCs0THVqRnpxYS9n?=
 =?utf-8?B?SnlieldITWcxcmJWNzh5VkFWZWJPSFlXcklNOTFZNHhCdjlxcDFrVFlLeDVO?=
 =?utf-8?B?UWJQY3dSSVZ3N0lpMHk0TUU4Y25FeDRiNENpR1VZMWV6UGVVLy9LZ3Fwd1ZP?=
 =?utf-8?B?NmtsWWZhOXR3Tm5FT0VCY2dXVnp0aFZzRmV4R3NVVUxhUy9icWN3bXk0M3lZ?=
 =?utf-8?B?NXJXSTFENitLczFCVnk3SjN4aG1pV2krWVdHWkVFZFhlU01MTmxhdXpHZGNs?=
 =?utf-8?Q?Ke7c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41835c34-91dc-467b-898c-08db97222953
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 08:41:58.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9nqI/f54wZ0HwP2XNT8/c+AkIFrsl8B7HDkw62LdNXTqdG5uH9KpGlxGXsXJ24WhWVygiuJyZ3JdEIcpNWBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiANCj4gDQo+IE9uIDAyLzA4LzIwMjMgMTQuMzMsIFdlaSBGYW5nIHdyb3RlOg0KPiA+Pj4gKwlz
dHJ1Y3QgeGRwX2ZyYW1lICp4ZHBmID0geGRwX2NvbnZlcnRfYnVmZl90b19mcmFtZSh4ZHApOw0K
PiA+PiBYRFBfVFggY2FuIGF2b2lkIHRoaXMgY29udmVyc2lvbiB0byB4ZHBfZnJhbWUuDQo+ID4+
IEl0IHdvdWxkIHJlcXVpcmVzIHNvbWUgcmVmYWN0b3Igb2YgZmVjX2VuZXRfdHhxX3htaXRfZnJh
bWUoKS4NCj4gPj4NCj4gPiBZZXMsIGJ1dCBJJ20gbm90IGludGVuZCB0byBjaGFuZ2UgaXQsIHVz
aW5nIHRoZSBleGlzdGluZyBpbnRlcmZhY2UgaXMgZW5vdWdoLg0KPiA+DQo+ID4+PiArCXN0cnVj
dCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gPj4+ICsJc3Ry
dWN0IGZlY19lbmV0X3ByaXZfdHhfcSAqdHhxOw0KPiA+Pj4gKwlpbnQgY3B1ID0gc21wX3Byb2Nl
c3Nvcl9pZCgpOw0KPiA+Pj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICpucTsNCj4gPj4+ICsJaW50
IHF1ZXVlLCByZXQ7DQo+ID4+PiArDQo+ID4+PiArCXF1ZXVlID0gZmVjX2VuZXRfeGRwX2dldF90
eF9xdWV1ZShmZXAsIGNwdSk7DQo+ID4+PiArCXR4cSA9IGZlcC0+dHhfcXVldWVbcXVldWVdOw0K
PiANCj4gTm90aWNlIGhvdyBUWFEgZ2V0cyBzZWxlY3RlZCBiYXNlZCBvbiBDUFUuDQo+IFRodXMg
aXQgd2lsbCBiZSB0aGUgc2FtZSBmb3IgYWxsIHRoZSBmcmFtZXMuDQo+IA0KWWVzLCBJJ2xsIG9w
dGltaXplIGl0LCB0aGFua3MhDQoNCj4gPj4+ICsJbnEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKGZl
cC0+bmV0ZGV2LCBxdWV1ZSk7DQo+ID4+PiArDQo+ID4+PiArCV9fbmV0aWZfdHhfbG9jayhucSwg
Y3B1KTsNCj4gPj4NCj4gPj4gSXQgaXMgc2FkIHRoYXQgWERQX1RYIHRha2VzIGEgbG9jayBmb3Ig
ZWFjaCBmcmFtZS4NCj4gPj4NCj4gPiBZZXMsIGJ1dCB0aGUgWERQIHBhdGggc2hhcmUgdGhlIHF1
ZXVlIHdpdGggdGhlIGtlcm5lbCBuZXR3b3JrIHN0YWNrLA0KPiA+IHNvIHdlIG5lZWQgYSBsb2Nr
IGhlcmUsIHVubGVzcyB0aGVyZSBpcyBhIGRlZGljYXRlZCBxdWV1ZSBmb3IgWERQDQo+ID4gcGF0
aC4gRG8geW91IGhhdmUgYSBiZXR0ZXIgc29sdXRpb24/DQo+ID4NCj4gDQo+IFllcywgdGhlIHNv
bHV0aW9uIHdvdWxkIGJlIHRvIGtlZXAgYSBzdGFjayBsb2NhbCAob3IgcGVyLUNQVSkgcXVldWUg
Zm9yIGFsbCB0aGUNCj4gWERQX1RYIGZyYW1lcywgYW5kIHNlbmQgdGhlbSBhdCB0aGUgeGRwX2Rv
X2ZsdXNoX21hcCgpIGNhbGwgc2l0ZS4gVGhpcyBpcw0KPiBiYXNpY2FsbHkgd2hhdCBoYXBwZW5z
IHdpdGggeGRwX2RvX3JlZGlyZWN0KCkgaW4gY3B1bWFwLmMgYW5kIGRldm1hcC5jDQo+IGNvZGUs
IHRoYXQgaGF2ZSBhIHBlci1DUFUgYnVsayBxdWV1ZSBhbmQgc2VuZHMgYSBidWxrIG9mIHBhY2tl
dHMgaW50bw0KPiBmZWNfZW5ldF94ZHBfeG1pdCAvIG5kb194ZHBfeG1pdC4NCj4gDQo+IEkgdW5k
ZXJzdGFuZCBpZiB5b3UgZG9uJ3Qgd2FudCB0byBhZGQgdGhlIGNvbXBsZXhpdHkgdG8gdGhlIGRy
aXZlci4NCj4gQW5kIEkgZ3Vlc3MsIGl0IHNob3VsZCBiZSBhIGZvbGxvd3VwIHBhdGNoIHRvIG1h
a2Ugc3VyZSB0aGlzIGFjdHVhbGx5DQo+IGltcHJvdmVzIHBlcmZvcm1hbmNlLg0KPiANClRoYW5r
cywgSSBnb3QgaXQuIEknbGwgb3B0aW1pemUgaW4gYSBmb2xsb3d1cCBwYXRjaCBpZiBpdCByZWFs
bHkgaW1wcm92ZXMgdGhlIHBlcmZvcm1hbmNlLg0K

