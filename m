Return-Path: <bpf+bounces-5241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37E758C1A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 05:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA8F1C20E82
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE723C25;
	Wed, 19 Jul 2023 03:29:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71917D5;
	Wed, 19 Jul 2023 03:29:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E235B5;
	Tue, 18 Jul 2023 20:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnZ/Z0/tgy7HkPvGgGgPptlOl8OnPfjxK4XCb632DfIlKbsb7a4PZ0+WLlpdz+EhWbIzPumXG/roYak0I0lorT+54V+WohvMEGv7wyFqPUIM5+WOVB1eJh0clURyoJ5piZhKA9GrL+WyC9CwLXMBdj1au/44khG4jgNcE/hE1nCxjPQ9Y9tlnuGTc6AH0g1m+SDp4wj0h7RlurKAk0FMNNs62hX0DFR/dHSzElC1zrswxKGqx+o75qUj6LA6QuNZ2YmBGnl/xDPKnVD/aRJ0OGEu08mVbqMGQTY6P2npDZEgnt7GznmoJlr2pZabvGxYAiyYPx8muaW3iTE+W06mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmjQLozZHIMcgJwKcGwSIxcM6V+uqzR9BqVuMN+2hmE=;
 b=j45WdOCWdhktPVJmkauwvBzr9O2DLxPUxLksYQ4CdgtKObcRdRam6CM7VWZ2YacBsdjx+42QDi9j3kX25QV/+9PtRlFE8JpAO+v6gpFMLB3OdbGdc3H602WOXZ1yxrmXVl0P1AMvAQtLduAkulycpHAulsvOSs0ZMElK7yNytV6FHxe41MVg8iLq6uh9l4jB0t/J5gD9oJka3DreSvJc0dMg35dr9TGxk91gq5RNgRg/GU8lAFuMy9GPueMcO97tXRDcW2klgBe+o20Qh4YqBg7ZVzjzR0dng8Z8zxOGJHQGQAZkgdCdWcmzl4MaFF7J17ZiCMQOllGgkTeIw60MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjQLozZHIMcgJwKcGwSIxcM6V+uqzR9BqVuMN+2hmE=;
 b=DoBPfyHERZlqJY+kumVGoNy3Kw/cREQ9b1TOed2MRRvq7NBhhAiF8duEtucshLnLu4+RzxzITuxWZJWql5IXmVnKhwrgaELASqvG5SyBOqp6+ZPZev5SSJfi+LK47h1ETempHHFFdnLu8ncCwjlPSA5diWjC1mYGLJFdjXA9ARM=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 03:28:26 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 03:28:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH net-next] net: fec: add XDP_TX feature support
Thread-Index: AQHZuJuObnt/EH25Q0eb312+ucAGVK+/o/SAgADGssA=
Date: Wed, 19 Jul 2023 03:28:26 +0000
Message-ID:
 <AM5PR04MB3139675725C77A4C06103DA48839A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
 <fa3dc82a-fe5e-a90c-6490-1661f1bb43d8@intel.com>
In-Reply-To: <fa3dc82a-fe5e-a90c-6490-1661f1bb43d8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAWPR04MB9934:EE_
x-ms-office365-filtering-correlation-id: 6db723f3-9539-4a55-1f22-08db880836d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dFQW9SX/2PPNk3bzjcfmoAu9Y6W29Z3Dn3x1zAMMiVyso4H+HfsP40gvA4qG914rjdC6x17fCT4YJlC/WRTN7rN6yE7Amz3dDSpcLMJTY/HaxB0IJVNC7bep9DdnNOMyrn5dP+ucW9QWrHN0Vfg0b6McK5fwFFkpBuNsG2J6GNon6RcOxcaS7az1ylzHJfaRpduVuwjxHzS9hiDVplSn8oe6FzdaYhYHes09Di5gELFOlTr5x27E4//+Ahfh8//NLVhEJWPnXty4acTPnqaRcfjLhcTf59/pdqqvfkn2Eas2uMgn59N/EPyFhr9KEx8oTssDxzFJFVTbK3Q8wtmy0r5A2qhRJe2mWuQ2+6Fh78mMtyfstkX7RjjLE/NdkjHyzl2A2KjzAD4I6rI9eknyi2K/bGhSWkQR0KqTmIpIJ7qpf7qP1ntO49dHsKYR4JGo2V6tYa1cfnzb++OQca+u4z9GAR4af0G30+dHk6QXCqzL9PdSU4dhst4oJfCO0XYKVZg8p6wKEOPk6uazUDLrf62CXS3ggW08WHGvIhSD37tkq7WkqcJJO/YRz2RZqcvNRra636J/qpZ7IAPXpl7m3ktpm902ARUHj0H4W6zVGxivuw4nZ26FY+Jw/c0Z+2z7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199021)(7696005)(53546011)(26005)(9686003)(6506007)(122000001)(83380400001)(86362001)(38070700005)(33656002)(38100700002)(186003)(55016003)(8676002)(8936002)(2906002)(41300700001)(478600001)(7416002)(4326008)(52536014)(66446008)(5660300002)(6916009)(316002)(66556008)(76116006)(66946007)(66476007)(64756008)(54906003)(44832011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WS9tTG9DZWF4OVlIMTBYRXdoNG9TVWJ4dHVsUUlaRVhIU3E2V252WjlsdUI1?=
 =?utf-8?B?NmhWQWpVY0dURmpXY0RwalhaTlhzenhnN0d2aUpVWHFLRWI3cUFSM2lkOVEx?=
 =?utf-8?B?bFNEejVCTDhiUExJNHhOOU9KMTh4UW1yN3VYU2Z0YzUxa2R3V3ZKTCtUbTRC?=
 =?utf-8?B?TFpOUk1zc0ZBSlhYVjExcHh5eWlnQnc4VFFFOEhSa2NLR1FCVDdJWDh6MjRC?=
 =?utf-8?B?a1JBYjhEdTdSSWN1dU52eUh6azMvNHlzKy9NZHo3WCtLei84RVhuMEQ0LzQr?=
 =?utf-8?B?YVpnZVNCY3JBSkduaU9ZWmtSdmtPSitzK2hIVjNSRlkyeVJrWnZkd0NVc1dI?=
 =?utf-8?B?M0kyM09wTWJEK1ZFai9aaTBYZVBXRzE0d00ycXpCSzVNYis5Z2g1WEtPNVBi?=
 =?utf-8?B?TGdiTW9BZEkybEVkdWp1a3UyRkFXT2JXR29BTHcyQ1NvWXRuODllM2ViVHp5?=
 =?utf-8?B?R2tWbStFRXdmRjhBSTVaYllZRGQwNWdxZFhkQ0N5WCt1aHF0QzY4aFhHVFkw?=
 =?utf-8?B?aHNJc3djNmdwOCttUTRlU2pzZ0h4M2pOSzlGSDNRZFdEb3RRcGE1Tzg3aEtR?=
 =?utf-8?B?SDNsY043ZjRhRys4WGVnOU5jSFBTYzcyT1VLZzFZQlFYWnM1R0V5eDhHUEQr?=
 =?utf-8?B?ZllRWXZBQVhSN0lVaVphb0NXaEUxaVVqWjlrbU9KcDNmSWpnYjVzYVBrYmV1?=
 =?utf-8?B?eXpKbnl4WEpkN1RIUmVZbS9ncldydzlBRDRnbDBhT1ZFZUdvSEJqdEQwcVZ1?=
 =?utf-8?B?aWE3MGJSMllzbWJJTVNzM0UxRDRrOTBianFvdDlpWk0vUnhONXU4MWdWSURt?=
 =?utf-8?B?QXNENjNrSEtkMSsrRk5QNUt4L1FFU1UyU3ByeERrRFc3dkNXZFhGV0lZaWRB?=
 =?utf-8?B?UERLNTNJRTBKSFRDTlBKdmtDZUN6UFhONEVxNjVSN1ZzaUU3RjROem5PWjVm?=
 =?utf-8?B?UU83VXk5MFZLRFIvOHRQVG9haXRMckJ1cWlZczlXNkZPalpCU0RXTEdQb1Jk?=
 =?utf-8?B?Yzh4SUd4TjVGQksvKzM3cW5tNFVoQTlGOVkvR3lEc3Y3TFdsVHhBTHNXSzN4?=
 =?utf-8?B?RFYzVTRLUlFtaXl1UnByVHI0Ujc2SXpvQ29ucUFPODJUWDBsZFpsbnNRcm1X?=
 =?utf-8?B?aGgrK29iQjlwekc5VzMwd2hkeU1KNHBRZVVuMWRCVUhoSHp6SWs2aGFGY0Z5?=
 =?utf-8?B?WmRrZTU0UVR3ZFVFWG9rRnVuc2JEZUd2Z1V1M25OczU1eGttVkI3VnhHYkJx?=
 =?utf-8?B?c1I4bk85UHJRVUFINDRqRk5PdHIrdG96czh4em1ZVHptKzV4eFhxdkVrQ3pv?=
 =?utf-8?B?L3d4cVZZSFJ0WVJSVTdTVXVEYWNoMkk4cmV5TmIzSG1VRXNvTjR1U1pVMjZt?=
 =?utf-8?B?QTNQZGEzd0lxTTRqZVUxOEI4ZHJ5S05OangwQmpKbmNDbFV1bHRmQUxpOXRh?=
 =?utf-8?B?YVl3dm1NR1owNFh0b1ZwVUt2dldCVmVVVG5xY0FTakxHc3VreTFPRUo2RmpN?=
 =?utf-8?B?aFQwRFpoS2sxMVZvNDNWaFVvSGlUVlZZYkUvZ2U5NGUwRHUyVVlhbThkV0p6?=
 =?utf-8?B?Z0hwRStsMWxZbE9Ra0ppWHVPYmxGSmVZVWNDdWRxMUplT2d4THhZOGZ4cjVS?=
 =?utf-8?B?SnRSSUQ3Z0JTNFpjeHA0RDg0RUptREVlOHdCUWNiaitSSjc5dWhSK1ZvekZ3?=
 =?utf-8?B?RU12NkdZSWhQNWQ1SmsvVHRrZVhaeERuaGpXMG1PNVNjNkVzTm1SSFFucmlZ?=
 =?utf-8?B?RWw4a3poYzBTMnBFc21jTWZ3dTJqV0RvcEo3MmkzR21oQ3Yya0l0RnJWbkxZ?=
 =?utf-8?B?NHRIVHRuM25CeEpoRWsrU2wrUnptYkgwYTBXUkRKV3ltaXBTS2lldGdMWmwy?=
 =?utf-8?B?VjdWMHYyaTFack9oWDZEL0VVN2xzKzBPUjZrTFJCMHkvVEtFVlVBSWVvZmh2?=
 =?utf-8?B?RDE4c1B6M09NUEhPZFkzajBDVk9IcmgyT1pOVllZc2xFckpKb2JYVkQ0eHRl?=
 =?utf-8?B?UTBDeFJKSUszYm1GV2dsRjA3VytkdHhmVW9sSEhuRFJ5MHVxcmZuN2M4bTBS?=
 =?utf-8?B?ekExSHg5MzUyZEdva0VCVytaS1Q5UXozOGlyc21lTE83a2N1SDZTdCtBYTRl?=
 =?utf-8?Q?ph2g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db723f3-9539-4a55-1f22-08db880836d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 03:28:26.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Q3Aj1GYyD1KKaaMwWMowN7D3gEDBWmsJz89FsBbVpjRsXqt/IOzofR5Ho++fDr4gT0sgAik97DHgjIzqH21Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDfmnIgxOOaXpSAy
MzoxNQ0KPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZl
bWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVu
aUByZWRoYXQuY29tOyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7DQo+IGhh
d2tAa2VybmVsLm9yZzsgam9obi5mYXN0YWJlbmRAZ21haWwuY29tOyBDbGFyayBXYW5nDQo+IDx4
aWFvbmluZy53YW5nQG54cC5jb20+OyBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29t
PjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBmZWM6IGFkZCBYRFBfVFgg
ZmVhdHVyZSBzdXBwb3J0DQo+IA0KPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4N
Cj4gRGF0ZTogTW9uLCAxNyBKdWwgMjAyMyAxODozNzowOSArMDgwMA0KPiANCj4gPiBUaGUgWERQ
X1RYIGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZCBiZWZvcmUsIGFuZCBhbGwgdGhlIGZyYW1lcyB3
aGljaA0KPiA+IGFyZSBkZWVtZWQgdG8gZG8gWERQX1RYIGFjdGlvbiBhY3R1YWxseSBkbyB0aGUg
WERQX0RST1AgYWN0aW9uLiBTbw0KPiA+IHRoaXMgcGF0Y2ggYWRkcyB0aGUgWERQX1RYIHN1cHBv
cnQgdG8gRkVDIGRyaXZlci4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBAIC0zODk3LDYgKzM5MjMs
MjkgQEAgc3RhdGljIGludCBmZWNfZW5ldF90eHFfeG1pdF9mcmFtZShzdHJ1Y3QNCj4gZmVjX2Vu
ZXRfcHJpdmF0ZSAqZmVwLA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IGZlY19lbmV0X3hkcF90eF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KPiA+
ICsJCQkJc3RydWN0IHhkcF9idWZmICp4ZHApDQo+ID4gK3sNCj4gPiArCXN0cnVjdCB4ZHBfZnJh
bWUgKnhkcGYgPSB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKHhkcCk7DQo+IA0KPiBIYXZlIHlv
dSB0cmllZCBhdm9pZCBjb252ZXJ0aW5nIGJ1ZmYgdG8gZnJhbWUgaW4gY2FzZSBvZiBYRFBfVFg/
IEl0IHdvdWxkIHNhdmUNCj4geW91IGEgYnVuY2ggb2YgQ1BVIGN5Y2xlcy4NCj4gDQpTb3JyeSwg
SSBoYXZlbid0LiBJIHJlZmVycmVkIHRvIHNldmVyYWwgZXRoZXJuZXQgZHJpdmVycyBhYm91dCB0
aGUgaW1wbGVtZW50YXRpb24gb2YNClhEUF9UWC4gTW9zdCBkcml2ZXJzIGFkb3B0IHRoZSBtZXRo
b2Qgb2YgY29udmVydGluZyB4ZHBfYnVmZiB0byB4ZHBfZnJhbWUsIGFuZA0KaW4gdGhpcyBtZXRo
b2QsIEkgY2FuIHJldXNlIHRoZSBleGlzdGluZyBpbnRlcmZhY2UgZmVjX2VuZXRfdHhxX3htaXRf
ZnJhbWUoKSB0bw0KdHJhbnNtaXQgdGhlIGZyYW1lcyBhbmQgdGhlIGltcGxlbWVudGF0aW9uIGlz
IHJlbGF0aXZlbHkgc2ltcGxlLiBPdGhlcndpc2UsIHRoZXJlDQp3aWxsIGJlIG1vcmUgY2hhbmdl
cyBhbmQgbW9yZSBlZmZvcnQgaXMgbmVlZGVkIHRvIGltcGxlbWVudCB0aGlzIGZlYXR1cmUuDQpU
aGFua3MhDQoNCj4gPiArCXN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAgPSBuZXRkZXZfcHJp
dihuZGV2KTsNCj4gPiArCXN0cnVjdCBmZWNfZW5ldF9wcml2X3R4X3EgKnR4cTsNCj4gPiArCWlu
dCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ID4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICpu
cTsNCj4gPiArCWludCBxdWV1ZSwgcmV0Ow0KPiA+ICsNCj4gPiArCXF1ZXVlID0gZmVjX2VuZXRf
eGRwX2dldF90eF9xdWV1ZShmZXAsIGNwdSk7DQo+ID4gKwl0eHEgPSBmZXAtPnR4X3F1ZXVlW3F1
ZXVlXTsNCj4gPiArCW5xID0gbmV0ZGV2X2dldF90eF9xdWV1ZShmZXAtPm5ldGRldiwgcXVldWUp
Ow0KPiA+ICsNCj4gPiArCV9fbmV0aWZfdHhfbG9jayhucSwgY3B1KTsNCj4gPiArDQo+ID4gKwly
ZXQgPSBmZWNfZW5ldF90eHFfeG1pdF9mcmFtZShmZXAsIHR4cSwgeGRwZiwgZmFsc2UpOw0KPiA+
ICsNCj4gPiArCV9fbmV0aWZfdHhfdW5sb2NrKG5xKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGZlY19lbmV0X3hkcF94bWl0KHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gIAkJCSAgICAgaW50IG51bV9mcmFtZXMsDQo+ID4gIAkJ
CSAgICAgc3RydWN0IHhkcF9mcmFtZSAqKmZyYW1lcywNCj4gPiBAQCAtMzkxNyw3ICszOTY2LDcg
QEAgc3RhdGljIGludCBmZWNfZW5ldF94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2
LA0KPiA+ICAJX19uZXRpZl90eF9sb2NrKG5xLCBjcHUpOw0KPiA+DQo+ID4gIAlmb3IgKGkgPSAw
OyBpIDwgbnVtX2ZyYW1lczsgaSsrKSB7DQo+ID4gLQkJaWYgKGZlY19lbmV0X3R4cV94bWl0X2Zy
YW1lKGZlcCwgdHhxLCBmcmFtZXNbaV0pIDwgMCkNCj4gPiArCQlpZiAoZmVjX2VuZXRfdHhxX3ht
aXRfZnJhbWUoZmVwLCB0eHEsIGZyYW1lc1tpXSwgdHJ1ZSkgPCAwKQ0KPiA+ICAJCQlicmVhazsN
Cj4gPiAgCQlzZW50X2ZyYW1lcysrOw0KPiA+ICAJfQ0KPiANCg0K

