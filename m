Return-Path: <bpf+bounces-7229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70260773B54
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 17:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CE2280D55
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA914A9D;
	Tue,  8 Aug 2023 15:42:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51513AC1;
	Tue,  8 Aug 2023 15:42:50 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::609])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75D4C2B;
	Tue,  8 Aug 2023 08:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbMxH4jVfHW26JUi/cHHV3tLN5CJCl/TTq5k0l+D5o02eFzrSqPkDebhnodhhkh3s77E39OKjjn2yktprJtDS4wZdEcxGfJlOeJorDqllF+ZNIoBSBI8PwuisIcuZ0M6DGRP5l1q46zVGOxlkDAfktf8i5vGaZ/Jn1CxBnkN687xt6zYDPC3c9WCTC8w/D4xoaJRTQv0ZRa8QrP+6dZtURO2706dAQe6yX7TIbPZIDfN6N/iGF6ctIkWWJpB7egKIkFIlIcAGkgIVfzoQholoZq5sz8W8OPhPN2ScwXkWnZzzHGzh6EeutpNoN2Lsx9lVwcdgMqCRCrNLemiswvZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGER//vpmB/Db5Hh+oaihr55hOfxfvaSzuO5x9zzx48=;
 b=EW2bsVFL99VYrMy6OsDrG0HXZP7S/STkGB+rSbcT3BjgCGEREzMgNEXPopwplOT3zNu0+IkIafHVQl7EvUQw6oHZltMSqTFLVNZvPtJP4ouY0AfUItM16actxw5hV0p2c2H+Cq8O3xrwCWRyfqphGaWl9cd3SCUTsFw44zahB6YQWb6zVwIDpFpjAx3Hzb6m0ng3yM/Zmw4o1qwUBLA6b4IwSKvUU6qRcl+vmKj4CWOmLNX4Q0NnbBKQzmqfewE3LTFw4TClPteKYTxOBoM2jhRyb2plsp/wWB6lqDyAH541m4WXGGPZb96wX1TqbT8yN3Tclx8kAMcxLVeDKPtpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGER//vpmB/Db5Hh+oaihr55hOfxfvaSzuO5x9zzx48=;
 b=oLPjPeN5wQZ3QKgBHTv21JzDa1CDpBuPyf/4QCTLLj5Nx2tTe2ULEjQhEDQFlI3pc8Tk6BNy2TMipleC94Xg9pl9gnJK69hNz+r8brxR7ok9IcviJIP1LlLMzfeJddEmRoRJtq69Hl1cB+SWplnvoPWbwo2Z4JdJ4Vo9XzAFpxI=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 05:02:17 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:02:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Topic: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Thread-Index:
 AQHZw3VFF5NSBizeREOxLxVc18wksa/XS8kAgACl6SCAAEHAAIAAOPLAgAAgSoCAAOhtQIAApJaAgAR1gPCAAExVAIAA3vKw
Date: Tue, 8 Aug 2023 05:02:17 +0000
Message-ID:
 <AM5PR04MB313980263DAD261D114B3DA4880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <20230802104706.5ce541e9@kernel.org>
 <AM5PR04MB313985C61D92E183238809138808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <1bf41ea8-5131-7d54-c373-00c1fbcac095@redhat.com>
 <AM5PR04MB31398ABF941EBDD0907E845B8808A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <cc24e860-7d6f-7ec8-49cb-a49cb066f618@kernel.org>
 <AM5PR04MB3139D8AAAB6B96B58425BBA08809A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <ba96db35-2273-9cc5-9a32-e924e8eff37c@kernel.org>
 <AM5PR04MB313903036E0DF277FEC45722880CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <8fd0313b-8f6f-9814-247d-c2687d053e2a@kernel.org>
In-Reply-To: <8fd0313b-8f6f-9814-247d-c2687d053e2a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB9154:EE_
x-ms-office365-filtering-correlation-id: 11b366dd-5361-478d-77f2-08db97cca33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dHLwy/ysNUWYEONjmNo5AtgpPY/nS3kw3weEksoODSZtNYvlrh7xUD98nbhy/mwO7Vr32APklleh6nZ9g23/cnBX44sCdK9JHRJ8Hd0/VbHyqdQEr9nXD3dN0wPen2U2LFsZzmNF3v42PppIdqSUMyE6YC/EzqFMyxZRNVdBGzJ1U4CZqLqY6QMgnQGY4oUg/NZTzvwjSiouchsqDhbbLdWiVR6KDLNtzpR6aJctMJvUH3ikSLdCyvwd/FFenugG0Sk1L0J69pXRKs33M4R/+Wz9rR8nOv5OfNax/iD/On21T/LLIS6/SSI4EulxlgDdydI/vOs/4hno/hR3sHi9zEvGterqVFvFM8vgnof8HdXCGzOWJIYMDiklsWmfzqDjMTfZu1ld5mPMZFIq3yPeE+xioTm4nqQXzoGixM1t65m2w4FZoKvQuAfU6L6B41/0uveLlIfuGttSOOjG9N311HLhpNAL/rMIaaYDjVuPJcFamg1ZhIG4/18eGWCuuB+Q78VObzWgf8YmtcxJ+UYMfr4A6wBepTuvdcX4oeljzFQhsq3P/u9LgjFSn7W4tCyXIGdZQCBJsfSapoKzL603miX02OD5j2dGMEtELQkLoEBz5DHXBQs9/eydcWV6XoMIvo+WRk/gsGdnpuFj+Op3kiENPYDLZCVpuUigzOaQLSYYfpOFMbz1VRjjLOhJI63E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(1800799003)(186006)(90011799007)(90021799007)(2906002)(83380400001)(5660300002)(71200400001)(38070700005)(54906003)(110136005)(38100700002)(7696005)(64756008)(122000001)(66556008)(66476007)(66446008)(76116006)(66946007)(9686003)(33656002)(4326008)(55016003)(316002)(41300700001)(86362001)(44832011)(8676002)(8936002)(26005)(7416002)(6506007)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlNtczlkSWdlWVRDNGYrdmRSSzhCTEV2OWZ2bE9yWDM3RjlydHYwSFkxaXlH?=
 =?utf-8?B?NUkyMHpNY1NNYUg4MUhNMVpmblRHbWxkd01QT2w5V2V2dEp6Nm1mTjQ2eDQ5?=
 =?utf-8?B?aFBCeVBsSjZJQ2ZnR1pJV3FqQzhOKzhObHJQWnNzOGJtTjJtb2hueDJHbFho?=
 =?utf-8?B?VzRwV1RmRWRpYlFjYU1OSm8yRGxhU1kvQXBSUUlBUnF1Y21pQW9DUDFBSm14?=
 =?utf-8?B?cFdxeXM5ODFDOGFKYUFlWk9HUmcwWmhNd05jbHNNbFl1NzZJc0QrYno0Qk84?=
 =?utf-8?B?MjBSOElCVWlRMGZwdnJxY1JpOGdvbmhBZ2ZEOWc4Wkw0d3BldDRiNklpQXZV?=
 =?utf-8?B?ZmIzeTFtb2FpbHA5VEVPVTZWYWlGSHVHa2laNU5iMit3S3BvTUMyakMrR0gw?=
 =?utf-8?B?T1NteWNqaWJ5YnZGK1Bkb0ZuRmdEZisyTWI1Qm1PN0c0Y1JFZlBWQ1ZBNFFx?=
 =?utf-8?B?NmxOQkVpZ1BOOURqM1k2cDMvMTdaTmVKYjJ6RDFJV3dRS3VxSElGMkZPNHdC?=
 =?utf-8?B?NnE1a0xWQnJIREV0N3dwNlJpMmlzOGtVL0pNWWM0QzZSWFlmMTgxNzBXYnUr?=
 =?utf-8?B?T1hYMElNZkFqZm8rRGwrSTRHUE8vaEZ2a0ZkeUpKV1hZdXQ3RnlPTmpsV1hh?=
 =?utf-8?B?c1ljV202YllNbDdBRnJHUzFYbTR4SG9iWi9hMkFQUnFNZXI4c3NiQlNBczEx?=
 =?utf-8?B?T0RFWkZwMUIrMVNWSEJMTHlYSGorbTZMdjhRempLOVI4RE1FcTBXWFNFUnJa?=
 =?utf-8?B?WUw0MjFpUWdjR0RoOVNDcXY2QnRITHFPWnZrdjdRRTV5QWMybmNLK2hUS094?=
 =?utf-8?B?WDFtZUpjbGtZZGVVYnZxa3MwcE1DY2JYenBtaE5aT3FzYUFETVhxWUIxY00r?=
 =?utf-8?B?WkovVTFlekZWQUtsbFA1cDVLTVhLYjA1OHpWVzhIRTJBWHkralQxQVJKV1hq?=
 =?utf-8?B?UmJPeE95Uzh2ZzBpSVhRK09GSCtObzFKRGVNbEYvR1VxNm5ZZDU2Smxod0gz?=
 =?utf-8?B?SzBNcGR5bVF5Y1Y4bFA0VTZXQ0ZmRm5BRktpREQ2cmxRRmp6SEk3Mm9YVzFr?=
 =?utf-8?B?VGZMOWtuODMxSHgvOU9jY0prSkhsK2l0TGg5YzFIZVJ5Sm5pK0JhVUQvZGov?=
 =?utf-8?B?bG81L05EdEs3QnlsUVBFL3lIK3k2Tmc1RUg5REk5Vzl3TVBLa0RreHJMVXNp?=
 =?utf-8?B?S0pUMmlkRi94U0ZFT0wwR2pUTkMxeUZ1MW4zb2lMREt2bVpRR2JUdDR3T0JW?=
 =?utf-8?B?RnZsVjBoZ2pkcGxOUmlodnBIb2pqY1JmYlFqNGk5cTdFZVgyWmFLWm9kRWZq?=
 =?utf-8?B?RFFNRVM2ZU9kcFhMNnY5Y3AzbVkzVkp4U0R6cGQ5cFhOSFlNSWVybUd6b3ZV?=
 =?utf-8?B?eFI0clZPRDFCYkxZYW00bTlEOTlTV1FSTVZRc3Yrb1ZmNy9QZyt6V2p4S1Q0?=
 =?utf-8?B?cDRnZDRWTlhnemZRK21NVWNmb2NrMDlxSUZIQ0M5VHpaUVZ5dXEvb3Y4ZitY?=
 =?utf-8?B?V1JoY2VPSU5IT3NTZHRNekp6U3RUT0lJQVkxMytTVWR1Y1dWQ1lYTWhDSkQ5?=
 =?utf-8?B?NEU4dys2dmRuRU9GZ1gxdi8rbERlYm0xTG1kV2JHdlFBVmVmRHo5LzNxaGVy?=
 =?utf-8?B?Q21uUEJVRzR1cTZDR2FkZGh0Tk5Zb08zSllTWHNqV0UvbkpCUXlnWUdjZEpp?=
 =?utf-8?B?RzBYZmpOUDArYUVkaVVwVXUzOUFZSTRWUXJjdy9pV0JBdjRySS9PNk43dDNX?=
 =?utf-8?B?Q2xPWmYyWkI5eTc2ZTBxU3VsYi9OSDBFQVZKWnY2T3JWU3dnUDVaS3lTSG96?=
 =?utf-8?B?V1pkMWpSNXJzTzJESGM4eDdCMXZLSHpyN1E5MFdBZWRqT0RQa2xkd3ZWYmtI?=
 =?utf-8?B?VngvVEIrcGloRGN3NElJTG5nK0ZZajN4RTRyZHVtVWtKUXVGQSsrVG01a3BB?=
 =?utf-8?B?VFFhUGp0RU9Kc2ozTUlsUHEyVzhqbmo0d0lkK3dFR2UwVEFLb1A2WGZiWTQ1?=
 =?utf-8?B?VHFqZHlaRXBFRHU3bjg5ZHRJNUlucUc1eW9rTm9HVFRTRWxBc0lIeGkrb1lF?=
 =?utf-8?B?YzhLNTZvMDAwWkF6K0dVVUJEN29NTy8zbFRneG1kQS90Q0ZPUytLanRITFds?=
 =?utf-8?Q?GULc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b366dd-5361-478d-77f2-08db97cca33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 05:02:17.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvgGxr0Iqwl5+Y6GG4Bq3MnfvV+4LQqN/ABNQMAEqoFosk1VpZsTLeyHPPgQP2SntbfRzjQhCD6G3G5l/xfZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiA+IEZvciBYRFBfUkVESVJFQ1QsIHRoZSBwZXJmb3JtYW5jZSBzaG93IGFzIGZvbGxvdy4NCj4g
PiByb290QGlteDhtcGV2azp+IyAuL3hkcF9yZWRpcmVjdCBldGgxIGV0aDAgUmVkaXJlY3Rpbmcg
ZnJvbSBldGgxDQo+ID4gKGlmaW5kZXggMzsgZHJpdmVyIHN0X2dtYWMpIHRvIGV0aDAgKGlmaW5k
ZXggMjsgZHJpdmVyIGZlYykNCj4gDQo+IFRoaXMgaXMgbm90IGV4YWN0bHkgdGhlIHNhbWUgYXMg
WERQX1RYIHNldHVwIGFzIGhlcmUgeW91IGNob29zZSB0byByZWRpcmVjdA0KPiBiZXR3ZWVuIGV0
aDEgKGRyaXZlciBzdF9nbWFjKSBhbmQgdG8gZXRoMCAoZHJpdmVyIGZlYykuDQo+IA0KPiBJIHdv
dWxkIGxpa2UgdG8gc2VlIGV0aDAgdG8gZXRoMCBYRFBfUkVESVJFQ1QsIHNvIHdlIGNhbiBjb21w
YXJlIHRvDQo+IFhEUF9UWCBwZXJmb3JtYW5jZS4NCj4gU29ycnkgZm9yIGFsbCB0aGUgcmVxdWVz
dHMsIGJ1dCBjYW4geW91IHByb3ZpZGUgdGhvc2UgbnVtYmVycz8NCj4gDQoNCk9oLCBzb3JyeSwg
SSB0aG91Z2h0IHdoYXQgeW91IHdhbnRlZCB3ZXJlIFhEUF9SRURJUkVDVCByZXN1bHRzIGZvciBk
aWZmZXJlbnQNCk5JQ3MuIEJlbG93IGlzIHRoZSByZXN1bHQgb2YgWERQX1JFRElSRUNUIG9uIHRo
ZSBzYW1lIE5JQy4NCnJvb3RAaW14OG1wZXZrOn4jIC4veGRwX3JlZGlyZWN0IGV0aDAgZXRoMA0K
UmVkaXJlY3RpbmcgZnJvbSBldGgwIChpZmluZGV4IDI7IGRyaXZlciBmZWMpIHRvIGV0aDAgKGlm
aW5kZXggMjsgZHJpdmVyIGZlYykNClN1bW1hcnkgICAgICAgIDIzMiwzMDIgcngvcyAgICAgICAg
MCBlcnIsZHJvcC9zICAgICAgMjMyLDM0NCB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNCw1Nzkg
cngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM0LDU3NyB4bWl0L3MNClN1bW1hcnkgICAg
ICAgIDIzNSw1NDggcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM1LDU0OSB4bWl0L3MN
ClN1bW1hcnkgICAgICAgIDIzNCw3MDQgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM0
LDcwMyB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNSw1MDQgcngvcyAgICAgICAgMCBlcnIsZHJv
cC9zICAgICAgMjM1LDUwNCB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNSwyMjMgcngvcyAgICAg
ICAgMCBlcnIsZHJvcC9zICAgICAgMjM1LDIyNCB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNCw1
MDkgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM0LDUwNyB4bWl0L3MNClN1bW1hcnkg
ICAgICAgIDIzNSw0ODEgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM1LDQ4MiB4bWl0
L3MNClN1bW1hcnkgICAgICAgIDIzNCw2ODQgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAg
MjM0LDY4MyB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNSw1MjAgcngvcyAgICAgICAgMCBlcnIs
ZHJvcC9zICAgICAgMjM1LDUyMCB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIzNSw0NjEgcngvcyAg
ICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM1LDQ2MSB4bWl0L3MNClN1bW1hcnkgICAgICAgIDIz
NCw2MjcgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM0LDYyNyB4bWl0L3MNClN1bW1h
cnkgICAgICAgIDIzNSw2MTEgcngvcyAgICAgICAgMCBlcnIsZHJvcC9zICAgICAgMjM1LDYxMSB4
bWl0L3MNCiAgUGFja2V0cyByZWNlaXZlZCAgICA6IDMsMDUzLDc1Mw0KICBBdmVyYWdlIHBhY2tl
dHMvcyAgIDogMjM0LDkwNA0KICBQYWNrZXRzIHRyYW5zbWl0dGVkIDogMywwNTMsNzkyDQogIEF2
ZXJhZ2UgdHJhbnNtaXQvcyAgOiAyMzQsOTA3DQo+IA0KPiBJJ20gcHV6emxlZCB0aGF0IG1vdmlu
ZyB0aGUgTU1JTyB3cml0ZSBpc24ndCBjaGFuZ2UgcGVyZm9ybWFuY2UuDQo+IA0KPiBDYW4geW91
IHBsZWFzZSB2ZXJpZnkgdGhhdCB0aGUgcGFja2V0IGdlbmVyYXRvciBtYWNoaW5lIGlzIHNlbmRp
bmcgbW9yZQ0KPiBmcmFtZSB0aGFuIHRoZSBzeXN0ZW0gY2FuIGhhbmRsZT8NCj4gDQo+IChtZWFu
aW5nIHRoZSBwa3RnZW5fc2FtcGxlMDNfYnVyc3Rfc2luZ2xlX2Zsb3cuc2ggc2NyaXB0IGZhc3Qg
ZW5vdWdoPykNCj4gDQoNClRoYW5rcyB2ZXJ5IG11Y2ghDQpZb3UgcmVtaW5kIG1lLCBJIGFsd2F5
cyBzdGFydGVkIHRoZSBwa3RnZW4gc2NyaXB0IGZpcnN0IGFuZCB0aGVuIHJhbiB0aGUgeGRwMg0K
cHJvZ3JhbSBpbiB0aGUgcHJldmlvdXMgdGVzdHMuIFNvIEkgc2F3IHRoZSB0cmFuc21pdCBzcGVl
ZCBvZiB0aGUgZ2VuZXJhdG9yDQp3YXMgYWx3YXlzIGdyZWF0ZXIgdGhhbiB0aGUgc3BlZWQgb2Yg
WERQX1RYIHdoZW4gSSBzdG9wcGVkIHRoZSBzY3JpcHQuIEJ1dA0KYWN0dWFsbHksIHRoZSByZWFs
LXRpbWUgdHJhbnNtaXQgc3BlZWQgb2YgdGhlIGdlbmVyYXRvciB3YXMgZGVncmFkZWQgdG8gYXMN
CmVxdWFsIHRvIHRoZSBzcGVlZCBvZiBYRFBfVFguDQoNClNvIEkgdHVybmVkIG9mZiB0aGUgcngg
ZnVuY3Rpb24gb2YgdGhlIGdlbmVyYXRvciBpbiBjYXNlIG9mIGluY3JlYXNpbmcgdGhlIENQVQ0K
bG9hZGluZyBvZiB0aGUgZ2VuZXJhdG9yIGR1ZSB0byB0aGUgcmV0dXJuZWQgdHJhZmZpYyBmcm9t
IHhkcDIuIEFuZCBJIHRlc3RlZA0KdGhlIHBlcmZvcm1hbmNlIGFnYWluLiBCZWxvdyBhcmUgdGhl
IHJlc3VsdHMuDQoNClJlc3VsdCAxOiBjdXJyZW50IG1ldGhvZA0Kcm9vdEBpbXg4bXBldms6fiMg
Li94ZHAyIGV0aDANCnByb3RvIDE3OiAgICAgMzI2NTM5IHBrdC9zDQpwcm90byAxNzogICAgIDMy
NjQ2NCBwa3Qvcw0KcHJvdG8gMTc6ICAgICAzMjY1MjggcGt0L3MNCnByb3RvIDE3OiAgICAgMzI2
NDY1IHBrdC9zDQpwcm90byAxNzogICAgIDMyNjU1MCBwa3Qvcw0KDQpSZXN1bHQgMjogc3luY19k
bWFfbGVuIG1ldGhvZA0Kcm9vdEBpbXg4bXBldms6fiMgLi94ZHAyIGV0aDANCnByb3RvIDE3OiAg
ICAgMzUzOTE4IHBrdC9zDQpwcm90byAxNzogICAgIDM1MjkyMyBwa3Qvcw0KcHJvdG8gMTc6ICAg
ICAzNTM5MDAgcGt0L3MNCnByb3RvIDE3OiAgICAgMzUyNjcyIHBrdC9zDQpwcm90byAxNzogICAg
IDM1MzkxMiBwa3Qvcw0KDQpOb3RlOiB0aGUgc3BlZWQgb2YgdGhlIGdlbmVyYXRvciBpcyBhYm91
dCA5MzUzOTdwcHMuDQoNCkNvbXBhcmVkIHJlc3VsdCAxIHdpdGggcmVzdWx0IDIuIFRoZSAic3lu
Y19kbWFfbGVuIiBtZXRob2QgYWN0dWFsbHkgaW1wcm92ZXMNCnRoZSBwZXJmb3JtYW5jZSBvZiBY
RFBfVFgsIHNvIHRoZSBjb25jbHVzaW9uIGZyb20gdGhlIHByZXZpb3VzIHRlc3RzIGlzICppbmNv
cnJlY3QqLg0KSSdtIHNvIHNvcnJ5IGZvciB0aGF0LiA6KA0KDQpJbiBhZGRpdGlvbiwgSSBhbHNv
IHRyaWVkIHRoZSAiZG1hX3N5bmNfbGVuIiArIG5vdCB1c2UgeGRwX2NvbnZlcnRfYnVmZl90b19m
cmFtZSgpDQptZXRob2QsIHRoZSBwZXJmb3JtYW5jZSBoYXMgYmVlbiBmdXJ0aGVyIGltcHJvdmVk
LiBCZWxvdyBpcyB0aGUgcmVzdWx0Lg0KDQpSZXN1bHQgMzogc3luY19kbWFfbGVuICsgbm90IHVz
ZSB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKCkgbWV0aG9kDQpyb290QGlteDhtcGV2azp+IyAu
L3hkcDIgZXRoMA0KcHJvdG8gMTc6ICAgICAzNjkyNjEgcGt0L3MNCnByb3RvIDE3OiAgICAgMzY5
MjY3IHBrdC9zDQpwcm90byAxNzogICAgIDM2OTIwNiBwa3Qvcw0KcHJvdG8gMTc6ICAgICAzNjky
MTQgcGt0L3MNCnByb3RvIDE3OiAgICAgMzY5MTI2IHBrdC9zDQoNClRoZXJlZm9yZSwgSSdtIGlu
dGVuZCB0byB1c2UgdGhlICJkbWFfc3luY19sZW4iKyBub3QgdXNlIHhkcF9jb252ZXJ0X2J1ZmZf
dG9fZnJhbWUoKQ0KbWV0aG9kIGluIHRoZSBWNSBwYXRjaC4gVGhhbmsgeW91IGFnYWluLCBKZXNw
ZXIgYW5kIEpha3ViLiBZb3UgcmVhbGx5IGhlbHBlZCBtZSBhIGxvdC4gOikNCg0K

