Return-Path: <bpf+bounces-4143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DCD749345
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D97D1C20C57
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4519BA47;
	Thu,  6 Jul 2023 01:44:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AD7F;
	Thu,  6 Jul 2023 01:44:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE11BD4;
	Wed,  5 Jul 2023 18:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AInZz415uQRIB4WMUKkqisyy/ZZSpKX5pwFwn4mIqEAvhudA0VsEB3/QAdqLnx+2ontxl3OMSgBWtaTRzfshxpnWvgLmXVPGWuUmc94YaRQsMX5Q2kamqkgXsJijDep0gdPpZZSW4iRWQGqhQ5JJ4n7mApNcKrpQvgE33O41RLs8odhLNdnyh6L30+UK5e+UQCWKbfD4BcJcwuUsTSHoP5dlEdI/3D98r/+A5LneaqVvWk4/PA3hOmdh3QoawsNlN2k3Pqnf8K6OhT1XEl5pHAaFKdfePbYD5VeMgwcMLmCHIY67QxM1yB9hZVN3fNLMp9XMQ5YKdkfWW1VzGbKGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/wQV5lxmSq9d3XoIgctzuMm4Cgtzr2llqasl3daUUY=;
 b=fb0iylAD1pHEwjpYCG9UqaJ7P4QVqZCrwq83eF/3R2x8XKz00QuJ5RJ0XoTXO+f0hMubHnVXeNHYz51UbOy/khuqetg5dmrjNwcp0xkjrVdXDpNSPVeHoTM6aDKB+llfjIF5v9yOvsiOAWQMZmtMYccCiPRq3tLfdNFpbywa/IQ9dQC9OA8TdqcvQjAEpIdohSh5m613ZCsdX/ZX94/DCJsjuIxu33eydMrqM8zdHv+3mPfFb86ZlQZuKED7y4Jjn3J7tEYJMm/v5TH8/H4DvvrleUr/9guihdIeQKbqN6nlc5XGU1CKmlRxt4Ndxk+Iji4p3A2lNz3BnhsLF8Z8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/wQV5lxmSq9d3XoIgctzuMm4Cgtzr2llqasl3daUUY=;
 b=hHSS+gpeguJQzN62NUDNG1+EFEgwKlvW8+NhmrFPeBDtv9QJqJxKrRZ2d4kYgOqDraAV2t7zlOzYYrEtLIV94hW20ooiishB2/hKhqwGRatiPljC1c+cw8hjfam+3TLDTKSjchQYvBNqiLbCNyPf3xTaWz8fzjzhJvb1tMEZY20=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 01:44:49 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 01:44:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net 3/3] net: fec: increase the size of tx ring and update
 thresholds of tx ring
Thread-Topic: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Thread-Index: AQHZrlKWMcGquWZZ5UGq1vf9jWNReK+qUaEAgAAZ9TCAAQ/2gIAAetPw
Date: Thu, 6 Jul 2023 01:44:49 +0000
Message-ID:
 <AM5PR04MB3139ED2B0F74BBD00B85A448882CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
	<20230704082916.2135501-4-wei.fang@nxp.com>
	<0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
	<AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230705111119.07c3dee3@kernel.org>
In-Reply-To: <20230705111119.07c3dee3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB8253:EE_
x-ms-office365-filtering-correlation-id: f3887931-0b2d-4ede-bb06-08db7dc295de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 561JfjSzbYFy6I1sib/cnDck/f9wL5uANu8ecT+jJ/XTPMqcdmaAEOYevJ4P5Lp8d7Soz0Z9sP7vd5o68hFlt2aR3d92RX9la8271/N+5/2JnVT4VLuRYH3D/PziGRPpBgyD0RKiu6YX7hnoP9lrbVDkO7CT8G3dWVem3yDXxm4/jRPWQRX10m7XKb+rVZxAZfdTQXtUkFzSMZD1oEX+dc9xOZIC4F7hqXqbvdAvUOKtGlASwPObN9RKZHbOkWAqyd2Z2L2EJYfTip/3i+SKVSu6zqcpqd5rRjcEDQe5DfMfkL7d9GpDZjLmgxhevJuJ6q36TdgBshBiB1TRnohp1knmd1yhZCPFJ1nrAqd7Imvi/qd7pI56cWJiJCCozjBmIyuPDy2qxHIkcAWfqQrQfL5iVV/olYFvIO5v1nD8wuL+mRgz/2LjdaSCdzxunbjnph2kjaLb/jhXG0cVty2lHqas2JWWiz7cYL5A0JX3opUt3jAGXwH7ZhjQLVHR+qs7UP/NiztC0rNDv82w176ZrTu8PGlXmTL3jVFfbJYuufpBx4f3IFZNy5LbxU1DbbMo6UI6J7bF+JHCfZKum0sh+j1JhktH4mvBlftxVoGkLk6vVuROqvEvfmVzkgkgZxZw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(44832011)(7416002)(6916009)(4326008)(66446008)(64756008)(66946007)(66476007)(66556008)(76116006)(33656002)(478600001)(2906002)(316002)(15650500001)(52536014)(8936002)(8676002)(5660300002)(41300700001)(55016003)(38070700005)(54906003)(86362001)(7696005)(53546011)(26005)(9686003)(186003)(6506007)(38100700002)(71200400001)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bHBCZkdCY2NZcmFlR0N2UzhwZ1UwYzdWM0pMVWp4Zyszcnpxb1Q4UTBXRWhw?=
 =?gb2312?B?anQzUmFmcGgwVFUwaElOSEtobmk4dXpWYVoweGtDUkJjdkIrSi9BNEg2eXMw?=
 =?gb2312?B?ajE0cFlSUVc5MWFKNFU0eW9PLytYSWNmNkgrd0k1SW02bkJZNnMzOW0wM1ln?=
 =?gb2312?B?bThRZjZlUXpDamhpMTNFUWRCNlhqYk0rRFV4d1hON0Rqek5DNEU2b2c2cXZV?=
 =?gb2312?B?Rzc5K1F0ZzBHdWxPRElUcjhXYksrVnp1Tm0vOU5VTlJNelc1UzN6aVV4NDIv?=
 =?gb2312?B?NE82SitLSU1UVStyUFB4WWdsMXpmTk9WTXRCU3JMVFJBYWtsNnU1aDB5aFdO?=
 =?gb2312?B?SEdSY1FXckIrbDJtUzZoTkNwcCt2S2dGdVFOQlpaRFdLdk9LUzhTT2MwTkNh?=
 =?gb2312?B?RVZna0JjaXZxbnRBU21BdVhhUDFIQTFHZERtLzhhaVFJT1ZwYXVWRkM5dFJX?=
 =?gb2312?B?MitRcGsycmZpTm5LTFVaK0l4OTM5TnIwY1QvQTFydE1LMkJrRXNPNzc2Rk1B?=
 =?gb2312?B?VkNyanhVeGJKZmRxdnB1RUNhWnhyeHV0Vk5FYlN1bUxRN1BhcTliM1FUbDJn?=
 =?gb2312?B?V01ROG5WZXl2dUkraUhxenp0NWp3Q0hlT0l5Z2N1eTg3RGNMdmNnaGNlRFpF?=
 =?gb2312?B?dmJQMWlNM29haEJrMGhxdHRhQ1V3UTdSWkRXNmZ3ZGpsNDRJVFdmMXRzM1Yv?=
 =?gb2312?B?SklORE4xRFFFdW8zRzNsSWxYY2l0STFXNi9sZGV2WEJMUVhwRmJnN05WVUxJ?=
 =?gb2312?B?Sk53Znhyck1DMkwvOFJnQVErOXRwd0RZTVF2Vy96SzNQMTZmWExRVzJ2Ymc2?=
 =?gb2312?B?bm1ySEZvQnhxdk5Yam4rL0FYd2YrYUszR0RqQStXNGdwUm41MjliNGYwL29L?=
 =?gb2312?B?b0NiTzdGRmRSVzVQUFdoNDdWdEd5S3JtWTZKLzhMSUlCRFh4d1FZSkExelRm?=
 =?gb2312?B?NDRORlFGdDQwYTJqSlVjRDI0SVI0blUwYm9KVk5CZGRoUFVHbW1iaXY2VzBO?=
 =?gb2312?B?TnpLN3NwMFN1OGtTQ0tWTWVabmZld1did1NhaTJNQi9Ua2VOU1VKQmlDeWZB?=
 =?gb2312?B?UmdQWEhKSU1uS3lsYnFKMUtjNmFpVUVDcnFNYnpBWjUrUlpTUmduRnkvc2J1?=
 =?gb2312?B?ekZwcWhQaWNoNHgrQnhBaVFOelViQ0VUckNtejZicDFwbXYyUU9tdDRGMTVw?=
 =?gb2312?B?VEptNkFGSjZHcFpPZ1NzeW01Y0VvUUQ5OXU3c1ZUMytIazBtL3ZBL29QQjFS?=
 =?gb2312?B?YnNBcktqbjhQOHc3MC9uWHpZbmZxWnlDcDlpVlJRcms3Njlwc3hieDVFcUJZ?=
 =?gb2312?B?R3lyMlMrRGFNcG1MejYvQ1plUGQ5aWtTOFIrYUpRT1ZDWktRZC9iQXhmanF5?=
 =?gb2312?B?L3BXdjVIb0lFVDFWZVM0Z2kvSXJDd2VwTmU5aXR6YjVocFdnU20zQ1MzdnBh?=
 =?gb2312?B?aEtPUytpZVBjYTlpVnNlTEhERFZWUnRSZ0VGTmF4M2NKdzRZejJDV3BFbmtY?=
 =?gb2312?B?bkZER0ZDN3gvcWhmZTFBQitrMVkwdmpFeHhWTXY3REsyQ3N1SXV1VFJDTUtC?=
 =?gb2312?B?c0NlQ0hHaG9sNkdnMC9rVVZUTmpYUFJhVkRjczF4YWlyYTFOdSs1TWhKQzNE?=
 =?gb2312?B?VjZWcDZIc0RIWnVyQm9BcGxTaWxzRnJabEJJbHZsNWRKdFUreENVa1hvdmsw?=
 =?gb2312?B?MTgwMk92b2xYbFQyNGhBbFhYenVMdjc4Nmh5ZkQyZVBtZ04wV0Z4YnprNzMy?=
 =?gb2312?B?V3BSV2w3WE5kZDZGWTNVVEJiMWs3VkFIM0JQV0k1WGpjMVN3Q01HUHF4VWpX?=
 =?gb2312?B?UFRwYytFQVQ2U0g0SXFRTzNvSHozNTd1dHFqdlJjKzhpZUs2UWNNMzVGRE9P?=
 =?gb2312?B?RUlDdkVETHBGZ2J0RDJXWFBiZEk4YitjcEZLanlVTWhtTzdwYlZGdFF4cWxC?=
 =?gb2312?B?WUh3TkcwQWN0bnhaV09XSDh6Z2JENnRzbkZLN0xhbDRuVlhBbmpUWW92RzVR?=
 =?gb2312?B?RnNYVVQ5bXFZd3pPc3JSVDltR25Ca2w4L3k3T2FIQlVjZlVEMEFYblhsS3RN?=
 =?gb2312?B?dUV2NjI1anRGVjAva1RaTkkrVzYrVEt3OWkwN2RJSFBhcnBtT3dnbTA3d0R6?=
 =?gb2312?Q?iySQ=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3887931-0b2d-4ede-bb06-08db7dc295de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 01:44:49.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYp+G7bLIy0DQSdbz/JvbKlXMt4YTkwPUdzrRC2jWWlCemehBcx3wuP9L0raVzN1iH/+75a2jN5t/TcANa2enQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo31MI2yNUgMjoxMQ0KPiBUbzogV2VpIEZhbmcg
PHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBk
YXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBwYWJlbmlAcmVkaGF0
LmNvbTsgYXN0QGtlcm5lbC5vcmc7DQo+IGRhbmllbEBpb2dlYXJib3gubmV0OyBoYXdrQGtlcm5l
bC5vcmc7IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsNCj4gU2hlbndlaSBXYW5nIDxzaGVud2Vp
LndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcNCj4gPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDMvM10gbmV0OiBmZWM6IGluY3JlYXNlIHRoZSBzaXplIG9m
IHR4IHJpbmcgYW5kIHVwZGF0ZQ0KPiB0aHJlc2hvbGRzIG9mIHR4IHJpbmcNCj4gDQo+IE9uIFdl
ZCwgNSBKdWwgMjAyMyAwNjoyMDoyNiArMDAwMCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+ID4gSW4g
YWRkdGlvbiwgdGhpcyBwYXRjaCBhbHNvIHVwZGF0ZXMgdGhlIHR4X3N0b3BfdGhyZXNob2xkIGFu
ZCB0aGUNCj4gPiA+ID4gdHhfd2FrZV90aHJlc2hvbGQgb2YgdGhlIHR4IHJpbmcuIEluIHByZXZp
b3VzIGxvZ2ljLCB0aGUgdmFsdWUgb2YNCj4gPiA+ID4gdHhfc3RvcF90aHJlc2hvbGQgaXMgMjE3
LCBob3dldmVyLCB0aGUgdmFsdWUgb2YgdHhfd2FrZV90aHJlc2hvbGQNCj4gPiA+ID4gaXMgMTQ3
LCBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRoYXQgdHhfd2FrZV90aHJlc2hvbGQgaXMgbGVzcyB0
aGFuDQo+ID4gPiA+IHR4X3N0b3BfdGhyZXNob2xkLg0KPiA+ID4NCj4gPiA+IFdoYXQgZG8gdGhl
c2UgYWN0dWFsbHkgbWVhbj8gSSBjb3VsZCBpbWFnaW5lIHRoYXQgYXMgdGhlIHJpbmcgZmlsbHMN
Cj4gPiA+IHlvdSBkb24ndCB3YW50IHRvIHN0b3AgdW50aWwgaXQgaXMgMjE3LzUxMiBmdWxsLiBU
aGVyZSBpcyB0aGVuIHNvbWUNCj4gPiA+IGh5c3RlcmVzaXMsIHN1Y2ggdGhhdCBpdCBoYXMgdG8g
ZHJvcCBiZWxvdyAxNDcvNTEyIGJlZm9yZSBtb3JlIGNhbiBiZQ0KPiBhZGRlZD8NCj4gPiA+DQo+
ID4gWW91IG11c3QgaGF2ZSBtaXN1bmRlcnN0b29kLCBsZXQgbWUgZXhwbGFpbiBtb3JlIGNsZWFy
bHksIHRoZSBxdWV1ZQ0KPiA+IHdpbGwgYmUgc3RvcHBlZCB3aGVuIHRoZSBhdmFpbGFibGUgQkRz
IGFyZSBsZXNzIHRoYW4gdHhfc3RvcF90aHJlc2hvbGQNCj4gPiAoMjE3IEJEcykuIEFuZCB0aGUg
cXVldWUgd2lsbCBiZSB3YWtlZCB3aGVuIHRoZSBhdmFpbGFibGUgQkRzIGFyZQ0KPiA+IGdyZWF0
ZXIgdGhhbiB0eF93YWtlX3RocmVzaG9sZA0KPiA+ICgxNDcgQkRzKS4gU28gaW4gbW9zdCBjYXNl
cywgdGhlIGF2YWlsYWJsZSBCRHMgYXJlIGdyZWF0ZXIgdGhhbg0KPiA+IHR4X3dha2VfdGhyZXNo
b2xkIHdoZW4gdGhlIHF1ZXVlIGlzIHN0b3BwZWQsIHRoZSBvbmx5IGVmZmVjdCBpcyB0byBkZWxh
eQ0KPiBwYWNrZXQgc2VuZGluZy4NCj4gPiBJbiBteSBvcGluaW9uLCB0eF93YWtlX3RocmVzaG9s
ZCBzaG91bGQgYmUgZ3JlYXRlciB0aGFuDQo+ID4gdHhfc3RvcF90aHJlc2hvbGQsIHdlIHNob3Vs
ZCBzdG9wIHF1ZXVlIHdoZW4gdGhlIGF2YWlsYWJsZSBCRHMgYXJlIG5vdA0KPiBlbm91Z2ggZm9y
IGEgc2tiIHRvIGJlIGF0dGFjaGVkLg0KPiA+IEFuZCB3YWtlIHRoZSBxdWV1ZSB3aGVuIHRoZSBh
dmFpbGFibGUgQkRzIGFyZSBzdWZmaWNpZW50IGZvciBhIHNrYi4NCj4gDQo+IEJ1dCB5b3Ugc2hv
dWxkbid0IHJlc3RhcnQgdGhlIHF1ZXVlIGZvciBhIHNpbmdsZSBwYWNrZXQgZWl0aGVyLg0KPiBS
ZXN0YXJ0aW5nIGZvciBhIHNpbmdsZSBwYWNrZXQgd2FzdGVzIENQVSBjeWNsZXMgYXMgdGhlcmUg
d2lsbCBiZSBtdWNoIG1vcmUNCj4gc3RvcCAvIHN0YXJ0IG9wZXJhdGlvbnMuIFR3byBsYXJnZSBw
YWNrZXRzIHNlZW0gbGlrZSB0aGUgYWJzb2x1dGUgbWluaW11bQ0KPiByZWFzb25hYmxlIHdha2Ug
dGhyZXNob2xkLg0KPiANCj4gU2V0dGluZyB0eF9zdG9wX3RocmVzaG9sZCB0byBNQVhfU0tCX0ZS
QUdTIGRvZXNuJ3Qgc2VlbSByaWdodCBlaXRoZXIsIGFzDQo+IHlvdSB3b24ndCBiZSBhYmxlIHRv
IGFjY2VwdCBhIGZ1bGwgVFNPIGZyYW1lLg0KPiANCk1heWJlIEkgc2hvdWxkIGtlZXAgdGhlIHR4
X3N0b3BfdGhyZXNob2xkIHVuY2hhbmdlZCwgc28gdGhhdCB0aGUgcXVldWUgaXMNCnRvIGJlIHN0
b3BwZWQgaWYgdGhlIGF2YWlsYWJsZSBCRHMgaXMgbm90IGVub3VnaCBmb3IgYSBmdWxsIFRTTyBm
cmFtZSB0byBiZSBhdHRhY2hlZC4NCkFuZCB0aGVuIGp1c3QgY2hhbmdlIHR4X3dha2VfdGhyZXNo
b2xkIHRvIHR4X3N0b3BfdGhyZXNob2xkICsgMSwgd2hpY2ggSSB0aGluayBpdCdzDQptb3JlIHJl
YXNvbmFibGUuDQoNCj4gUGxlYXNlIHNwbGl0IHRoZSBjaGFuZ2UsIHRoZSBuZXRkZXZfZXJyX29u
Y2UoKSBzaG91bGQgYmUgb25lIHBhdGNoIGFuZCB0aGVuDQo+IHRoZSBjaGFuZ2UgdG8gd2FrZSB0
aHJlc2ggYSBzZXBhcmF0ZSBvbmUuDQpPa2F5LCB0aGFua3MhDQo=

