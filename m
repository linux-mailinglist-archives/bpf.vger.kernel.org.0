Return-Path: <bpf+bounces-5411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38F75A47A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 04:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8761C211A2
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B001115;
	Thu, 20 Jul 2023 02:44:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73738A;
	Thu, 20 Jul 2023 02:44:20 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B492107;
	Wed, 19 Jul 2023 19:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As61Wtq9EvxEmzMcE7a90qHvgNM9DOQ9jyJV9Ct+7Re8PqcMLV1nOmD33yp7Aoz8QbjBt4eCHtHOxW9TBPoWEtAmnUof6KC8POQ2PCTdIkY7d8eC/2N9R1kdPZ0v21oH7uhjwyL0hsAa2NiltufdMhlgTAoH0eKPmFpO608V2ie4JADrYWaVhb4A+57ZwCKbTlVDYYetdvzR4gA6puNBAZ5QpSdwknEyqzJNGtP+eW4o1ZT7QVPXGZTGnzmsZtQH79+pJ76RR2TfAHqLC9xIFbgkib1YST3VLfl6K98x8dvof5QQV6ugDzP5Q7ZZu4q6Bm8KBamIKC7WFZ7BnlixmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZiXfu3SLidSCisUwR9H2RWQ/yGs8nwNiEGvxn6G6P4=;
 b=e7qT/brrWDfqg3kh87McDUpA7OWBaTM3cw/lWxj7juhR7RnL3umutZmPBCRTAhdj+MJvBK7++pIlrKBpVvTrlSgRJ84fi6EX1xXaEucNUTkusrygTCAMg2c78HD0fS580fAsSS+Ihz2fxb8All4or7SyW+zws4tKK65Vnvo8APhEUQYenX3pvq9U20UgvZUYyYrXGNnlAmkK/qDKi7JJvrVovLeZeZqgrZmnuH07jxcGgiO8F1TnkSlAjlHTdjNSCOjwv3X3V9mQzXpH8+DzyShWnqhGRkESD5hdQFE8wF7Q/ImWz3Rd5s0N1wi6uGBQPBv4bbjMsshbv+6SgoIW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZiXfu3SLidSCisUwR9H2RWQ/yGs8nwNiEGvxn6G6P4=;
 b=em2XHjbHPzq7ibEyseSpwyQzxsfIpjgr/ePjtJtpmPv4xgRE2VS2O/OuP7MAvxO8Zx8Qa5qwMUI4N4K5VJAyGSM9q7ybJh66HVJclZZGNmIcPodFCkmNYKLIGajESrj6SRt5jECZo3D8lieE/P85DQbyh7pXoWFOzodgJo4HOoQ=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 02:44:15 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 02:44:15 +0000
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
Thread-Index: AQHZuJuObnt/EH25Q0eb312+ucAGVK+/o/SAgADGssCAAOU0AIAAoUaQ
Date: Thu, 20 Jul 2023 02:44:15 +0000
Message-ID:
 <AM5PR04MB31395D906EC23A91D561ED12883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
 <fa3dc82a-fe5e-a90c-6490-1661f1bb43d8@intel.com>
 <AM5PR04MB3139675725C77A4C06103DA48839A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <e0d85f3a-377b-dd29-3125-c5c304d9d234@intel.com>
In-Reply-To: <e0d85f3a-377b-dd29-3125-c5c304d9d234@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DUZPR04MB10062:EE_
x-ms-office365-filtering-correlation-id: 167abbf0-2921-4dc1-40d3-08db88cb34fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lMngh6r+oRhYtGIj/24Ln0Z3fB2KuF7XSFAZfwTITPudgGwvbPwtMh899HOBVj8Vh8J3/1yB34Z5L1cCFj5OYx69yh1hKZKSQCYK3ZFRfg3z0xk77eOh9KHaOAQ6ls2ccGeAwuX4c50J9bTa/iJeGUCSzONtWyXyIJqaBRVO3G2v4yftkzehSbmh83cH7C6Mfbke6hthCWQMKoycGTZ832Bx2JlDWpeRyYSp8O2QzzGAuUa4+Qfl28Aw0y2UzbPPEfLKXDMAHpUXUWD2KS/PrIyKU1AQEF6Oj8fa7+xf4tUbkTFawGLiPiEs5mwNG8AQoW/C6rrHP9Vd7rES3RcvG+Pfpw7Q65td4Ct+dEf1XpJRZesuxKywuEvO0btTJOnV94raHiOt4EjG7PGLeWIfOKgwzJ4nPmpqlQcVViTGu9cUksol+kV5fmqVV986SvsWCjIIxMVIXkQBjBOQ2TF5DAnKtvSf47Cb2aZnH/Up4Cl8iySPj0XFMxQt/6ZlSziBj+E16QswhTpqc29nff5p0MH4DfFWaMbXANIJMtLL8IMX3t0UamdH0r/PceMyR1hQnwxuAmdiWVFXPlyiC7DSntgr2ZA7RNOyChPFPfmSo1K+dhDmgKbPQbus7Q4XGAlM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(478600001)(55016003)(86362001)(122000001)(44832011)(7416002)(41300700001)(71200400001)(4326008)(6916009)(76116006)(66946007)(66476007)(66446008)(66556008)(316002)(64756008)(38070700005)(33656002)(5660300002)(54906003)(52536014)(8676002)(8936002)(83380400001)(9686003)(38100700002)(26005)(186003)(2906002)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFVkVlJHSGVOVkJYOTdsN1hmNVNzZ2pyK3RmQnlmYUZ1dnN2QmZ6cy9HMDM4?=
 =?utf-8?B?dlI0NFVPWHNOR3RMMEozN09CSk51WXBpd3NoeXF4cGpnZTBIRjg1NTNKUWph?=
 =?utf-8?B?dnN5VkxQSnJYZzdvYUVBVWltMzB6akRpK2hjVU5PaGFXeXdzS0Y5RU80ak9q?=
 =?utf-8?B?L1QremdSL2Z5Wk1JdHEvczlBTFBVbWFmY2FJZzgrVWRPUDI4NHZjUENZalBU?=
 =?utf-8?B?UkgyTHRQZllZQWtabEhMVHNjMFM1ZFlvMllQU1NHRFpoKzEwb0NBZ09GKytO?=
 =?utf-8?B?d1RheUlBQXZ0NS9adCt0WjU4YU81TFZML2tTVmxHTHVaTm4veUdXOGExZjNp?=
 =?utf-8?B?WmN0M1RFQmFxZ2V3aGFDVXF3eGpnUzAvRlBxeWhNcWFMMThhd0hPUVVzaFR4?=
 =?utf-8?B?RlRQd0loYWFBckRTc25mbXhPV3NqMjZKT3l0akV6TkJWb0N1UThZSEZzNEl1?=
 =?utf-8?B?V2RXbElsaGdBZW1jOTZzaTBibTlxakpodmUwdGlDOHNYZHhrWlVjdEFSODVo?=
 =?utf-8?B?TmpUcU5Za3V4OWYzZklpQlRsQW9IazN0QjZsUm9WQVRSc1loZjY0c2lvTUcx?=
 =?utf-8?B?My9ENU5wNjFuTjhmVmNCNnNUYTZ6R0dkdnFlcy9ycytnQ09jRXlYdEFCaXI0?=
 =?utf-8?B?Ynp1YjRySXpqNkxsc09VQ0c1OWVIUWU4Mm5meEVBNGdOQ2NZeTlreW9ONjFE?=
 =?utf-8?B?NGxIRkJ6OHRQUlB6bnJWU0hJNHBDc05TSEJsTmo2ckl0S0d3U2lVdUVlVEtG?=
 =?utf-8?B?azk5dExKd2lMUXMwZ1RhbWdCTWRxQ0ZhUnNDaU1uT092WGdhVWV1Z1VTQWV0?=
 =?utf-8?B?eWlLM0JZOStHcll0Vlc4V01nWURmMWV6eVhRM3JSS2F6Zlo3dFp3VC81Y1hV?=
 =?utf-8?B?cWtDNDY2M2tUeTR4Sm5ESWRRWHBteUtHQkhsTEM1UnlUdGs2YThyWlZtNHRt?=
 =?utf-8?B?SzVkNkJtUXBSdjR3VE0zamNrcmUxN2ZScFBacWk5ZEpMcFN0c3BubVJWNjZy?=
 =?utf-8?B?a1ErN1RBSG0zNnF4c0QzR2hZVkp5MFN5TkN6VVhuK1RxUzIyYktSSFllR0c5?=
 =?utf-8?B?MHZVMFNrWVVsZ0lJNjROd1dYRkVIOVpXSUpuRDhML3prWHRrMnkzOUV3TE40?=
 =?utf-8?B?MU8rVWhWdHNZYWJoOHMza01pZDhTcjRUTTRyZ0tTd0YrM2lPTEZ4MWVFRmty?=
 =?utf-8?B?WjdORVRMM0xCUjJCenM2ZzhuTDlKSHZIbXdkZzRQak5SRmc1ZkwvVjhUc1RY?=
 =?utf-8?B?VmlPOVhqR0dwWVl3TnNwMHpzMisxckk1RERWdU90L0NKUE01VFQxS1pxa0pQ?=
 =?utf-8?B?dmhqMjFLbi95K3N4dmYvOXRPR2ZHOTF6NEVFVlA4NmpiN0NQNUFXUHYyMGZK?=
 =?utf-8?B?dXZGT3N6eW5WWEp6QWFkb0sreW1VVGdOZlJkMklTcWgyRVliWXFITVBuV0t0?=
 =?utf-8?B?eCt1bU5LbmFWemNsYVg0cXNNb2U3aHlqWHJQUkhkZ0VBNXkrYy9lNXQ3MmpM?=
 =?utf-8?B?S0hXdjVJcTBTb3lnenppQVVCMk1SZFgwVkQ2N1JLY1JoRHY4clV2dXM2OVRY?=
 =?utf-8?B?cGk1ckZHZ0VrUm5EK1FyNmE3MkdTcFFiMnBkVCtIbnNpVEVpOVpabGdHL1Qw?=
 =?utf-8?B?UWRSUUFNMDQ2ZzFrd3hXZDZBSDVYWEhML3JhM3dVZ0NpVUFTVko2SE5mUWFF?=
 =?utf-8?B?MzBNeE9TRWpXb2hNdjBNVlUvMEZLUDRSTGNpbnJIVWVDcy9zQkZLSHJkNUZV?=
 =?utf-8?B?USs4RjVKZmlFeWMrdmczSXBSRGlKSzAraHFYZW9USHZIOGtBbHkrU1d3Z0Yr?=
 =?utf-8?B?N0NyV3M5RklZT2ZTWjVHL2JheDhISGM5NXZqT3BNWHQxTEVPdGhuNUFYM1Nu?=
 =?utf-8?B?WDg0ell4eTBMSGVyMkFTbWlCMVVrRitObytxYVVUQVN6eGxhTkFnaVZaeDVj?=
 =?utf-8?B?THBmTTNVQmRjclFYbVo1N0R3Q1Y4MUYyRXd2TXYxVldsMkJHbm50V1QvVDFF?=
 =?utf-8?B?MVlUaUJqZXBoWVJvRGJyWWlNQzJmMno5emVVNVA4OHpHMXpKSmZOWmVJN2lY?=
 =?utf-8?B?ZXpnV0NMenFwWDJ2aElxa1JBWm8rdENvMVNIWlVHWnRFbG9wU28zWlh3R0FB?=
 =?utf-8?Q?I8iI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 167abbf0-2921-4dc1-40d3-08db88cb34fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 02:44:15.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: md0cou/NAZD3P/6hdPJBFCt6HJjPHL6EW4L9xy3VWanbYEq2fiIYsmtxzSpcRkInppltIlmv96S6PJkmqadpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDfmnIgyMOaXpSAw
OjQ2DQo+IFRvOiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5p
QHJlZGhhdC5jb207IGFzdEBrZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsNCj4gaGF3
a0BrZXJuZWwub3JnOyBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207IENsYXJrIFdhbmcNCj4gPHhp
YW9uaW5nLndhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSBuZXQ6IGZlYzogYWRkIFhEUF9UWCBm
ZWF0dXJlIHN1cHBvcnQNCj4gDQo+IEZyb206IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiBEYXRlOiBXZWQsIDE5IEp1bCAyMDIzIDAzOjI4OjI2ICswMDAwDQo+IA0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8YWxla3Nh
bmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gPj4gU2VudDogMjAyM+W5tDfmnIgxOOaXpSAyMzox
NQ0KPiA+PiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4+IENjOiBkYXZlbUBk
YXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+ID4+
IHBhYmVuaUByZWRoYXQuY29tOyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7
DQo+ID4+IGhhd2tAa2VybmVsLm9yZzsgam9obi5mYXN0YWJlbmRAZ21haWwuY29tOyBDbGFyayBX
YW5nDQo+ID4+IDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBTaGVud2VpIFdhbmcgPHNoZW53ZWku
d2FuZ0BueHAuY29tPjsNCj4gPj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dF0g
bmV0OiBmZWM6IGFkZCBYRFBfVFggZmVhdHVyZSBzdXBwb3J0DQo+ID4+DQo+ID4+IEZyb206IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+PiBEYXRlOiBNb24sIDE3IEp1bCAyMDIzIDE4
OjM3OjA5ICswODAwDQo+ID4+DQo+ID4+PiBUaGUgWERQX1RYIGZlYXR1cmUgaXMgbm90IHN1cHBv
cnRlZCBiZWZvcmUsIGFuZCBhbGwgdGhlIGZyYW1lcyB3aGljaA0KPiA+Pj4gYXJlIGRlZW1lZCB0
byBkbyBYRFBfVFggYWN0aW9uIGFjdHVhbGx5IGRvIHRoZSBYRFBfRFJPUCBhY3Rpb24uIFNvDQo+
ID4+PiB0aGlzIHBhdGNoIGFkZHMgdGhlIFhEUF9UWCBzdXBwb3J0IHRvIEZFQyBkcml2ZXIuDQo+
ID4+DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4+PiBAQCAtMzg5Nyw2ICszOTIzLDI5IEBAIHN0YXRp
YyBpbnQgZmVjX2VuZXRfdHhxX3htaXRfZnJhbWUoc3RydWN0DQo+ID4+IGZlY19lbmV0X3ByaXZh
dGUgKmZlcCwNCj4gPj4+ICAJcmV0dXJuIDA7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICtzdGF0
aWMgaW50IGZlY19lbmV0X3hkcF90eF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LA0KPiA+
Pj4gKwkJCQlzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkNCj4gPj4+ICt7DQo+ID4+PiArCXN0cnVjdCB4
ZHBfZnJhbWUgKnhkcGYgPSB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKHhkcCk7DQo+ID4+DQo+
ID4+IEhhdmUgeW91IHRyaWVkIGF2b2lkIGNvbnZlcnRpbmcgYnVmZiB0byBmcmFtZSBpbiBjYXNl
IG9mIFhEUF9UWD8gSXQgd291bGQNCj4gc2F2ZQ0KPiA+PiB5b3UgYSBidW5jaCBvZiBDUFUgY3lj
bGVzLg0KPiA+Pg0KPiA+IFNvcnJ5LCBJIGhhdmVuJ3QuIEkgcmVmZXJyZWQgdG8gc2V2ZXJhbCBl
dGhlcm5ldCBkcml2ZXJzIGFib3V0IHRoZQ0KPiBpbXBsZW1lbnRhdGlvbiBvZg0KPiA+IFhEUF9U
WC4gTW9zdCBkcml2ZXJzIGFkb3B0IHRoZSBtZXRob2Qgb2YgY29udmVydGluZyB4ZHBfYnVmZiB0
byB4ZHBfZnJhbWUsDQo+IGFuZA0KPiA+IGluIHRoaXMgbWV0aG9kLCBJIGNhbiByZXVzZSB0aGUg
ZXhpc3RpbmcgaW50ZXJmYWNlIGZlY19lbmV0X3R4cV94bWl0X2ZyYW1lKCkNCj4gdG8NCj4gPiB0
cmFuc21pdCB0aGUgZnJhbWVzIGFuZCB0aGUgaW1wbGVtZW50YXRpb24gaXMgcmVsYXRpdmVseSBz
aW1wbGUuIE90aGVyd2lzZSwNCj4gdGhlcmUNCj4gPiB3aWxsIGJlIG1vcmUgY2hhbmdlcyBhbmQg
bW9yZSBlZmZvcnQgaXMgbmVlZGVkIHRvIGltcGxlbWVudCB0aGlzIGZlYXR1cmUuDQo+ID4gVGhh
bmtzIQ0KPiANCj4gTm8gcHJvYmxlbSwgaXQgaXMganVzdCBGWUksIGFzIHdlIG9ic2VydmUgd29y
c2UgcGVyZm9ybWFuY2Ugd2hlbg0KPiBjb252ZXJ0X2J1ZmZfdG9fZnJhbWUoKSBpcyB1c2VkIGZv
ciBYRFBfVFggdmVyc3VzIHdoZW4geW91IHRyYW5zbWl0IHRoZQ0KPiB4ZHBfYnVmZiBkaXJlY3Rs
eS4gVGhlIG1haW4gcmVhc29uIGlzIHRoYXQgY29udmVydGluZyB0byBYRFAgZnJhbWUNCj4gdG91
Y2hlcyAtPmRhdGFfaGFyZF9zdGFydCBjYWNoZWxpbmUgKHVzdWFsbHkgdW50b3VjaGVkKSwgd2hp
bGUgeGRwX2J1ZmYNCj4gaXMgYWx3YXlzIG9uIHRoZSBzdGFjayBhbmQgaG90Lg0KPiBJdCBpcyB1
cCB0byB5b3Ugd2hhdCB0byBwaWNrIGZvciB5b3VyIGRyaXZlciBvYnZpb3VzbHkgOikNCj4gDQpU
aGFua3MgZm9yIHlvdXIgaW5mb3JtYXRpb24uIEZvciBub3csIHRoZSBjdXJyZW50IFhEUF9UWCBw
ZXJmb3JtYW5jZSBjYW4gbWVldA0Kb3VyIGV4cGVjdGF0aW9uLiBJJ2xsIGtlZXAgeW91ciBzdWdn
ZXN0aW9uIGluIG1pbmQgYW5kIHRyeSB5b3VyIHN1Z2dlc3Rpb24gaWYgd2UgaGF2ZQ0KaGlnaGVy
IHBlcmZvcm1hbmNlIHJlcXVpcmVtZW50LiA6RA0KDQo+ID4NCj4gPj4+ICsJc3RydWN0IGZlY19l
bmV0X3ByaXZhdGUgKmZlcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiA+Pj4gKwlzdHJ1Y3QgZmVj
X2VuZXRfcHJpdl90eF9xICp0eHE7DQo+ID4+PiArCWludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lk
KCk7DQo+ID4+PiArCXN0cnVjdCBuZXRkZXZfcXVldWUgKm5xOw0KPiA+Pj4gKwlpbnQgcXVldWUs
IHJldDsNCj4gPj4+ICsNCj4gPj4+ICsJcXVldWUgPSBmZWNfZW5ldF94ZHBfZ2V0X3R4X3F1ZXVl
KGZlcCwgY3B1KTsNCj4gPj4+ICsJdHhxID0gZmVwLT50eF9xdWV1ZVtxdWV1ZV07DQo+ID4+PiAr
CW5xID0gbmV0ZGV2X2dldF90eF9xdWV1ZShmZXAtPm5ldGRldiwgcXVldWUpOw0KPiA+Pj4gKw0K
PiA+Pj4gKwlfX25ldGlmX3R4X2xvY2sobnEsIGNwdSk7DQo+ID4+PiArDQo+ID4+PiArCXJldCA9
IGZlY19lbmV0X3R4cV94bWl0X2ZyYW1lKGZlcCwgdHhxLCB4ZHBmLCBmYWxzZSk7DQo+ID4+PiAr
DQo+ID4+PiArCV9fbmV0aWZfdHhfdW5sb2NrKG5xKTsNCj4gPj4+ICsNCj4gPj4+ICsJcmV0dXJu
IHJldDsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiAgc3RhdGljIGludCBmZWNfZW5ldF94ZHBf
eG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiA+Pj4gIAkJCSAgICAgaW50IG51bV9mcmFt
ZXMsDQo+ID4+PiAgCQkJICAgICBzdHJ1Y3QgeGRwX2ZyYW1lICoqZnJhbWVzLA0KPiA+Pj4gQEAg
LTM5MTcsNyArMzk2Niw3IEBAIHN0YXRpYyBpbnQgZmVjX2VuZXRfeGRwX3htaXQoc3RydWN0IG5l
dF9kZXZpY2UNCj4gPj4gKmRldiwNCj4gPj4+ICAJX19uZXRpZl90eF9sb2NrKG5xLCBjcHUpOw0K
PiA+Pj4NCj4gPj4+ICAJZm9yIChpID0gMDsgaSA8IG51bV9mcmFtZXM7IGkrKykgew0KPiA+Pj4g
LQkJaWYgKGZlY19lbmV0X3R4cV94bWl0X2ZyYW1lKGZlcCwgdHhxLCBmcmFtZXNbaV0pIDwgMCkN
Cj4gPj4+ICsJCWlmIChmZWNfZW5ldF90eHFfeG1pdF9mcmFtZShmZXAsIHR4cSwgZnJhbWVzW2ld
LCB0cnVlKSA8IDApDQo+ID4+PiAgCQkJYnJlYWs7DQo+ID4+PiAgCQlzZW50X2ZyYW1lcysrOw0K
PiA+Pj4gIAl9DQo+ID4+DQo+ID4NCj4gDQo+IFRoYW5rcywNCj4gT2xlaw0K

